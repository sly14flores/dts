angular.module('app-module', ['bootstrap-modal','ui.bootstrap']).factory('app', function($http,$timeout,$window,bootstrapModal) {
	
	function app() {

		var self = this;
		
		self.data = function(scope) {

			scope.formHolder = {};
			
			scope.views = {};
			
			scope.receive = {};
			scope.activity = {};
			
			scope.documents = [];
			
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
			
			scope.currentPage = scope.views.currentPage;
			scope.pageSize = 10;
			scope.maxSize = 5;
			
			$http({
			  method: 'GET',
			  url: 'handlers/documents.php'
			}).then(function mySuccess(response) {
				
				scope.documents = angular.copy(response.data);
				scope.filterData = scope.documents;
				scope.currentPage = scope.views.currentPage;
				
			}, function myError(response) {
				
			});				
			
		};
		
		function barcodeAsyncSuggest(scope) { // barcode-async-suggest

			scope.barcodeAsyncSuggest = function(f) {
				
				return $http({
				  method: 'POST',
				  url: 'handlers/barcode-async-suggest.php',
				  data: {filter: f}
				}).then(function mySucces(response) {
					
					return response.data;
					
				},
				function myError(response) {

				});					
				
			};
			
			scope.barcodeAsyncSuggest('');
		
		};

		self.receive = function(scope,doc) {

			barcodeAsyncSuggest(scope);
		
			title = 'Receive '+doc.doc_type;

			scope.receive = angular.copy(doc);

			var onOk = function() {

				if (validate(scope,'receive')) return false;				
				
				$http({
				  method: 'POST',
				  url: 'handlers/doc-receive.php',
				  data: scope.receive
				}).then(function mySuccess(response) {

					self.list(scope);

				}, function myError(response) {

					//

				});
				
				return true;
				
			};
		
			bootstrapModal.box(scope,title,'dialogs/doc-receive.html',onOk);
			
		};

		self.activity = function(scope,doc) {
			
			title = 'Transact '+doc.doc_type;

			scope.activity = angular.copy(doc);

			var onOk = function() {

				if (validate(scope,'activity')) return false;				
				
				$http({
				  method: 'POST',
				  url: 'handlers/doc-transaction.php',
				  data: scope.activity
				}).then(function mySuccess(response) {

					// self.list(scope);

				}, function myError(response) {
					
					//
					
				});

				return true;

			};

			bootstrapModal.box2(scope,title,'dialogs/doc-activity.html',onOk);		

		};

	};

	return new app();

});