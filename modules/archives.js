angular.module('app-module', ['form-validator','bootstrap-modal','notifications-module']).factory('app', function($http,$timeout,$compile,$window,validate,bootstrapModal) {

	function app() {

		var self = this;
		
		self.data = function(scope) {

			scope.formHolder = {};
			scope.views = {};

			scope.activity = {};
			
			scope.archives = [];	
			
			self.list(scope);

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

			$('#content').load('lists/archive.html',function() {
				$timeout(function() { $compile($('#content')[0])(scope); }, 500);
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
			
		};
		
		$('#content').load('forms/archive.html',function() {
				$timeout(function() { $compile($('#content')[0])(scope); }, 500);
			});	

	};

	return new app();

});