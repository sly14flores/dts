angular.module('app-module', ['bootstrap-modal','ui.bootstrap','window-open-post']).factory('app', function($http,$timeout,$window,bootstrapModal,printPost) {
	
	function app() {

		var self = this;
		
		self.data = function(scope) {

			scope.formHolder = {};
			
			scope.views = {};
			
			scope.receive = {};
			
			scope.incomings = [];
			
			scope.views.currentPage = 1;

			scope.$watch(function(scope) {
				
				return scope.search;
				
			},function(newValue, oldValue) {
				
				$timeout(function() { $('[data-toggle="tooltip"]').tooltip(); },500);
				
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

		self.list = function(scope) {
						
			if (scope.$id > 2) scope = scope.$parent;
			
			scope.currentPage = scope.views.currentPage;
			scope.pageSize = 10;
			scope.maxSize = 5;
			
			$http({
			  method: 'GET',
			  url: 'handlers/incomings.php'
			}).then(function mySuccess(response) {
				
				scope.incomings = angular.copy(response.data);
				scope.filterData = scope.incomings;
				scope.currentPage = scope.views.currentPage;
				
			}, function myError(response) {
				
			});				
			
		};

		function barcodeAsyncSuggest(scope) {

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
		
		self.barcodeSelected = function(scope,item) {
			
			scope.receive.barcode = item;
			
		};		
		
	};
	
	return new app();
	
});