angular.module('app-module', ['form-validator','bootstrap-modal']).factory('app', function($http,$timeout,$window,validate,bootstrapModal) {

	function app() {

		var self = this;
		
		self.data = function(scope) {

			scope.formHolder = {};
			scope.views = {};

			scope.documents = [];	

		};

		self.list = function(scope) {
			
			if (scope.$id > 2) scope = scope.$parent;
			
			$http({
			  method: 'GET',
			  url: 'handlers/archives.php'
			}).then(function mySuccess(response) {

				scope.documents = angular.copy(response.data);			

			}, function myError(response) {

				//

			});				

		};

	};

	return new app();

});