angular.module('app-module', ['bootstrap-modal','ui.bootstrap']).factory('app', function($http,$timeout,$window,bootstrapModal) {
	
	function app() {

		var self = this;
		
		self.data = function(scope) {

			scope.formHolder = {};
			
			scope.views = {};
			
			scope.incoming = {};
			
			scope.incoming.id = 0;
			
			scope.incoming = [];
			
			scope.options = [];
			
			scope.views.currentPage = 1; // for pagination
			
			$http({
				method: 'GET',
				url: 'handlers/options.php'
			}).then(function mySuccess(response) {
				
				scope.options = angular.copy(response.data);
					
			}, function myError(response) {
		
		
		
			});	
			
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
				
				scope.incoming = angular.copy(response.data);
				scope.filterData = scope.offices; // for pagination
				scope.currentPage = scope.views.currentPage; // for pagination 	
				
			}, function myError(response) {
				
			});				
			
		};
		
		self.add = function(scope,doc_type) {
			
			
			
			if (doc_type == null) {				
				
				scope.doc_type = {};
				scope.doc_type.id = 0;
				
			} else {
				
				title = 'Incoming Document';
				
				$http({
				  method: 'POST',
				  url: 'handlers/doctype-view.php',
				  data: {id: doc_type.id}
				}).then(function mySuccess(response) {
					
					scope.doc_type = angular.copy(response.data);			
					
				}, function myError(response) {
					
					//
					
				});					
				
			};

			var onOk = function() {

				if (validate(scope,'doc_type')) return false;				
				
				$http({
				  method: 'POST',
				  url: 'handlers/doctype-save.php',
				  data: scope.doc_type
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