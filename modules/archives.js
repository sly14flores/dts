angular.module('app-module', ['form-validator','bootstrap-modal']).factory('app', function($http,$timeout,$window,validate,bootstrapModal) {

	function app() {

		var self = this;
		
		self.data = function(scope) {

			scope.formHolder = {};
			scope.views = {};

			scope.activity = {};
			
			scope.archives = [];	

		};

		self.list = function(scope) {
			
			if (scope.$id > 2) scope = scope.$parent;
			
			$http({
			  method: 'GET',
			  url: 'handlers/archives.php'
			}).then(function mySuccess(response) {

				scope.archives = angular.copy(response.data);			

			}, function myError(response) {

				//

			});				

		};
		
		self.view = function(scope,archive) {
			
			title = '<strong>'+archive.doc_name+'</strong> ('+archive.doc_type+')';

			scope.activity = angular.copy(archive);			

			$http({
			  method: 'POST',
			  url: 'handlers/doc-activity.php',
			  data: {id: archive.id}
			}).then(function mySuccess(response) {

				scope.activity.tracks = response.data.tracks;
				scope.activity.files = response.data.files;
				scope.activity.attachments = response.data.attachments;

			}, function myError(response) {
				
				//
				
			});			

			var onOk = function() {

			};

			bootstrapModal.box2(scope,title,'dialogs/archive.html',onOk);			
			
		};

	};

	return new app();

});