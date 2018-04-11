angular.module('app-module', ['form-validator','ui.bootstrap','bootstrap-modal','window-open-post','notifications-module']).factory('app', function($http,$timeout,$window,validate,bootstrapModal,printPost,bootstrapModal) {
	
	function app() {

		var self = this;
		
		self.data = function(scope) {

			scope.formHolder = {};
			scope.views = {};

			scope.activity = {};
			
			scope.documents = [];	
			
			scope.views.currentPage = 1;
			
			scope.$watch(function(scope) {
				
				return scope.search;
				
			},function(newValue, oldValue) {
				
				$timeout(function() { $('[data-toggle="tooltip"]').tooltip(); },500);
				
			});

		};		

		self.list = function(scope) {
			
			if (scope.$id > 2) scope = scope.$parent;
			
			scope.currentPage = scope.views.currentPage;
			scope.pageSize = 10;
			scope.maxSize = 3;
			
			$http({
			  method: 'GET',
			  url: 'handlers/documents-list.php'
			}).then(function mySuccess(response) {

				scope.documents = angular.copy(response.data);	

				scope.filterData = scope.documents;
				scope.currentPage = scope.views.currentPage;				

			}, function myError(response) {

				//

			});				

		};
		
		self.view = function(scope,document) {
			
			title = '<strong>'+document.doc_name+'</strong> ('+document.doc_type+')';

			scope.activity = angular.copy(document);			

			$http({
			  method: 'POST',
			  url: 'handlers/doc-activity.php',
			  data: {id: document.id}
			}).then(function mySuccess(response) {

				scope.activity.tracks = response.data.tracks;
				scope.activity.files = response.data.files;
				scope.activity.attachments = response.data.attachments;

			}, function myError(response) {
				
				//
				
			});			

			var onOk = function() {

			};

			bootstrapModal.box2(scope,title,'dialogs/document.html',onOk);			

		};

		self.delete = function(scope,doc) {
			
			scope.views.currentPage = scope.currentPage;

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
		
		self.preview = function(file) {

			printPost.show('preview/index.php',file);
			
		};
		
	};

	return new app();

});