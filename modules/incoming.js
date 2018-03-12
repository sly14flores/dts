angular.module('app-module', ['bootstrap-modal','ui.bootstrap']).factory('app', function($http,$timeout,$window,bootstrapModal) {
	
	function app() {

		var self = this;
		
		self.data = function(scope) {

			scope.formHolder = {};
			
			scope.views = {};
			
			scope.incoming = {};
			
			scope.incomings = [];
			
			scope.views.currentPage = 1; // for pagination
			
		};
		
		function validate(scope,form) {
			
			var controls = scope.formHolder[form].$$controls;
			
			angular.forEach(controls,function(elem,i) {

				if (elem.$$attr.$attr.required) {
					
					scope.$apply(function() {
						
						elem.$touched = elem.$invalid;
						
					});
					
				};
									
			});

			return scope.formHolder[form].$invalid;
			
		};
		
		self.delete = function(scope, row) {
			
			scope.views.currentPage = scope.currentPage; // for pagination	
			
			var onOk = function() {
				
				$http({
					method: 'POST',
					url: 'handlers/doctype-delete.php',
					data: {id: row.id}
				}).then(function mySuccess(response) {
					
						self.list(scope);
						
				}, function myError(response) {
			

			
				});

			};
			
			var onCancel = function() { };
			
			bootstrapModal.confirm(scope,'Confirmation','Are you sure you want to Delete?',onOk,onCancel);
			
		};

		self.list = function(scope) {
						
			if (scope.$id > 2) scope = scope.$parent;
			
			scope.currentPage = scope.views.currentPage; // for pagination
			scope.pageSize = 10; // for pagination
			scope.maxSize = 5; // for pagination
			
			$http({
			  method: 'GET',
			  url: 'handlers/incoming.php'
			}).then(function mySuccess(response) {
				
				scope.incomings = angular.copy(response.data);
				scope.filterData = scope.incomings; // for pagination
				scope.currentPage = scope.views.currentPage; // for pagination 	
				
			}, function myError(response) {
				
			});				
			
		};
		
		self.receive = function(scope,doc) {
			console.log(doc);
			title = doc.doc_type;
			date = doc.date_enrolled;
			
			var m_names = new Array("January","February","March","April","May","June","July","August","September","October","November","December");
			
			var month = parseInt(date.substring(5,7));
		
			date = m_names[month-1] + " " + date.substring(8,10) + ", " + date.substring(0,4); 
			
			scope.incoming = angular.copy(doc);
			
			scope.incoming.date = date;
			var onOk = function() {

				if (validate(scope,'incoming')) return false;				
				
				$http({
				  method: 'POST',
				  url: 'handlers/doc-receive.php',
				  data: scope.incoming
				}).then(function mySuccess(response) {				
					
					self.list(scope);
					
				}, function myError(response) {
					
					//
					
				});
				
				return true;
				
			};
		
			bootstrapModal.box(scope,title,'dialogs/incoming.html',onOk);
			
		};	

	};

	return new app();

});