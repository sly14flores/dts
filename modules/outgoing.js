angular.module('app-module', ['bootstrap-modal','ui.bootstrap','window-open-post']).factory('app', function($http,$timeout,$window,bootstrapModal,printPost) {
	
	function app() {

		var self = this;
		
		self.data = function(scope) {

			scope.formHolder = {};
			
			scope.views = {};
			
			scope.activity = {};
			
			scope.outgoings = [];
			
			scope.views.currentPage = 1;	
		
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
			  url: 'handlers/outgoings.php'
			}).then(function mySuccess(response) {
				
				scope.outgoings = angular.copy(response.data);
				scope.filterData = scope.outgoings;
				scope.currentPage = scope.views.currentPage;
				
			}, function myError(response) {
				
			});				
			
		};
		
		self.tracks = function(scope,outgoing) {

			title = '<strong>'+outgoing.doc_name+'</strong> ('+outgoing.doc_type+')';

			scope.activity = angular.copy(outgoing);			

			$http({
			  method: 'POST',
			  url: 'handlers/doc-activity.php',
			  data: {id: outgoing.id}
			}).then(function mySuccess(response) {

				scope.activity.tracks = response.data.tracks;
				scope.activity.files = response.data.files;
				scope.activity.attachments = response.data.attachments;

			}, function myError(response) {
				
				//
				
			});			

			var onOk = function() {

			};

			bootstrapModal.box2(scope,title,'dialogs/outgoing-tracks.html',onOk);

		};

	};
	
	return new app();
	
});