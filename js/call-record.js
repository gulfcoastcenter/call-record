var gcc;
(function(gcc) { 
   gcc.callrecord =  function(RU) {

var model = {
   counties: ko.observableArray(),
   states: ko.observableArray(),
   calls: ko.observableArray(),
   updatelist: ko.observable(false),
   matches: ko.observableArray(),
   updatematches: ko.observable(false),
   has_match: ko.observable(false),
   cmhc: ko.observableArray(),
   activecall: ko.observable(),
   editedcall: ko.observable(),
   new_call: function() {
         model.activate_call({id: 'new'});
      },
   activate_call: function(call) { 
      model.updatelist(!model.updatelist());
      model.updatematches(!model.updatematches());
      console.log('activate:', call.id);
      $.get('api/call/' + call.id, function(details) {
         var det = JSON.parse(details);
         console.log(details);
         model.activecall({
            id: ko.observable(det.id),
            program: ko.observable(det.program),
            date: ko.observable(det.date),
            caller: ko.observable(det.caller),
            patient: ko.observable(det.patient),
            cmhcid: ko.observable(det.cmhcid),
            phone: ko.observable(det.phone),
            county: ko.observable(det.county),
            city: ko.observable(det.city),
            street: ko.observable(det.street),
            state: ko.observable(det.state),
            zip: ko.observable(det.zip),
            referredto: ko.observable(det.referredto),
            referredfrom: ko.observable(det.referredfrom),
            request: ko.observable(det.request),
            historypreviousid: ko.observable(det.historypreviousid),
            historynextid: ko.observable(det.historynextid),
            status: ko.observable(det.status)
         });
         $('.date').datepicker();
      });
   },
   copy_match:function(match) {
            model.activecall().program(match.program);
            model.activecall().caller(match.caller);
            model.activecall().patient(match.patient);
            model.activecall().cmhcid(match.cmhcid);
            model.activecall().phone(match.phone);
            model.activecall().county(match.county);
            model.activecall().city(match.city);
            model.activecall().street(match.street);
            model.activecall().state(match.state);
            model.activecall().zip(match.zip);
   },
   copy_cmhc:function(match) {
            model.activecall().cmhcid(match.id);
            model.activecall().patient(match.name);
            model.activecall().phone(match.phone);
            model.activecall().county(match.county);
            model.activecall().city(match.city);
            model.activecall().street(match.street);
            model.activecall().state(match.state);
            model.activecall().zip(match.zip);
   },
   get_prev: function() {
      model.activate_call({id: model.activecall().historypreviousid()});
   },
   get_next: function() {
      model.activate_call({id: model.activecall().historynextid()});
   },
   clear_active: function() {
      model.activecall('');
      model.matches('');
   },
   edit_active: function() {
      var call = model.activecall();
      model.editedcall({
         id: call.id(),
         program: call.program(),
         date: call.date(),
         caller: call.caller(),
         patient: call.patient(),
         cmhcid: call.cmhcid(),
         phone: call.phone(),
         county: call.county(),
         city: call.city(),
         street: call.street(),
         state: call.state(),
         zip: call.zip(),
         referredto: call.referredto(),
         referredfrom: call.referredfrom(),
         request: call.request()
      });
   }

};
ko.computed(function() { 
   var self = this;
   var doupdate = self.updatelist();
   //var calls = self.calls();
   $.get('api/calls/' + RU, function(calllist) {
      console.log(calllist);
      var cl = JSON.parse(calllist);
      self.calls(cl);
      //self.calls(JSON.parse(calllist));
   });
}, model);
ko.computed(function() {
   var self = this;
   var doupdate = self.updatematches();
   var thiscall = self.activecall();
   if (!thiscall) return;
   $.post('api/possiblematches', {
      caller: thiscall.caller(),
      excludeid: thiscall.id(),
      patient: thiscall.patient(),
      phone: thiscall.phone()
      }, function(matchlist) {

      console.log(matchlist);
      var ml = JSON.parse(matchlist);
      self.matches(ml);
   });
}, model);
ko.computed(function() {
   var self = this;
   var doupdate = self.updatematches();
   var thiscall = self.activecall();
   if (!thiscall) return;
   $.post('api/possiblecmhcmatches', {
      patient: thiscall.patient()
      }, function(cmhclist) {
      console.log(cmhclist);
      var cl = JSON.parse(cmhclist);
      self.cmhc(cl);
   });
}, model);
ko.computed(function() {
   var self = this;
   var call = self.editedcall();
   if (!call) return;
   if (call.id) {
      $.post('api/editcall', call, 
         function(res) { 
            //self.clear_active();
            console.log('edit results', res);
            self.activate_call(JSON.parse(res));
            //self.activecall.id(res.id);
            //self.activecall.historyid(res.historyid);
            //self.calls('');
         })
   } else {
      call.program = RU;
      console.log(call);
      $.post('api/addcall/' + RU, call,
         function(res) {
            console.log(res);
            self.activate_call(JSON.parse(res));
         });
   }

}, model);
ko.computed(function() {
   this.has_match( this.matches().length > 0 || this.cmhc().length > 0);
}, model);

$.get('api/counties', function(counties) {
   var c = JSON.parse(counties);
   model.counties(c);
});
$.get('api/states', function(states) {
   var s = JSON.parse(states);
   model.states(s);
});

ko.applyBindings(model);
}
})(gcc || (gcc =  {}));
