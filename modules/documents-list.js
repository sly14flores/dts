angular.module('app-module', ['form-validator','bootstrap-modal']).factory('app', function($http,$timeout,$window,validate,bootstrapModal) {
	
	function app() {

		var self = this;
		
		self.data = function(scope) {

			scope.formHolder = {};
			scope.views = {};

			scope.documents = [];	

		};
		
		self.delete = function(scope,doc) {
			
			var onOk = function() {
				
				$http({
					method: 'POST',
					url: 'handlers/delete-documents.php',
					data: {id: doc.id}
				}).then(function mySuccess(response) {
					
					self.list(scope);
						
				}, function myError(response) {
			
				});

			};
			
			bootstrapModal.confirm(scope,'Confirmation','Are you sure you want to delete this document?',onOk,function() {});
				
		};

		self.list = function(scope) {
			
			if (scope.$id > 2) scope = scope.$parent;
			
			$http({
			  method: 'GET',
			  url: 'handlers/documents-list.php'
			}).then(function mySuccess(response) {

				scope.documents = angular.copy(response.data);			

			}, function myError(response) {

				//

			});				

		};

	};

	return new app();

});