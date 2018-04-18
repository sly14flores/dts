angular.module('app-module', ['bootstrap-modal','ui.bootstrap','window-open-post','notifications-module','ngRoute']).config(function($routeProvider) {
    $routeProvider.when('/:option/:id', {
        templateUrl: 'transact.html'
    });	
}).factory('app', function($http,$timeout,$compile,$window,bootstrapModal,printPost,$routeParams,$location) {
	
	function app() {

		var self = this;
		
		self.data = function(scope) {

			scope.formHolder = {};
			
			scope.views = {};
			
			scope.receive = {};
			scope.activity = {};
			
			scope.documents = [];
			
			scope.views.currentPage = 1; // for pagination
			
			/* scope.$watch(function(scope) {
				
				return scope.search;
				
			},function(newValue, oldValue) {
				
				$timeout(function() { $('[data-toggle="tooltip"]').tooltip(); },500);
				
			});	 */		

			scope.$on('$routeChangeSuccess', function() {

				if ($routeParams.option != undefined) {
					
					if ($routeParams.id != undefined) {
						
						$timeout(function() {
							
							$http({
							  method: 'POST',
							  url: 'handlers/document.php',
							  data: {id: $routeParams.id}
							}).then(function mySuccess(response) {

								self.activity(scope,response.data);

							}, function myError(response) {
								
							});								
							
						}, 1000);

					};
					
				};			

			});
			
			self.list(scope);
			
		};

		function validate(scope,form) {
			
			var controls = scope.formHolder[form].$$controls;
			
			angular.forEach(controls,function(elem,i) {

				if (elem.$$attr.$attr.required) {

					elem.$touched = elem.$invalid;

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
			  url: 'handlers/documents.php'
			}).then(function mySuccess(response) {
				
				scope.documents = angular.copy(response.data);
				scope.filterData = scope.documents;
				scope.currentPage = scope.views.currentPage;
				// $timeout(function() { $('[data-toggle="tooltip"]').tooltip(); },500);
				
			}, function myError(response) {
				
			});
			
			$('#content').load('lists/transact.html',function() {
				$timeout(function() { $compile($('#content')[0])(scope); }, 500);
			});			
			
		};		

		self.activity = function(scope,doc) {

			scope.activity = angular.copy(doc);

			scope.activity.next = {};

			options(scope);
			offices(scope);

			scope.staffs = [];
			
			$http({
			  method: 'POST',
			  url: 'handlers/doc-activity.php',
			  data: {id: doc.id}
			}).then(function mySuccess(response) {

				scope.activity.tracks = response.data.tracks;
				scope.activity.files = response.data.files;
				scope.activity.attachments = response.data.attachments;

			}, function myError(response) {
				
				//
				
			});

			$('#content').load('forms/transact.html',function() {
				$timeout(function() { $compile($('#content')[0])(scope); }, 500);
			});			

		};

		self.save = function(scope) {
			
			if (validate(scope,'activity')) return false;				
			
			scope.activity.options = scope.options;
			
			$http({
			  method: 'POST',
			  url: 'handlers/doc-transaction.php',
			  data: scope.activity
			}).then(function mySuccess(response) {

				self.list(scope);

			}, function myError(response) {
				
				//
				
			});			
			
		};
		
		function options(scope) {

			scope.options = [];
		
			$http({
				method: 'GET',
				url: 'handlers/options.php'
			}).then(function mySuccess(response) {
				
				scope.options = angular.copy(response.data);
					
			}, function myError(response) {
				
		
			});			
		
		};

		function offices(scope) {

			scope.offices = [];
		
			$http({
				method: 'GET',
				url: 'handlers/offices.php'
			}).then(function mySuccess(response) {
				
				scope.offices = angular.copy(response.data);
					
			}, function myError(response) {
				
		
			});			
		
		};	
		
		self.optionChosen = function(scope,opt) {
			
			var index = scope.options.indexOf(opt);
			
			angular.forEach(scope.options,function(option,i) {
				
				if (typeof option.value === 'boolean') {

					if (i != index) scope.options[i].value = false;

				};

			});
			
		};
		
		self.preview = function(file) {

			printPost.show('preview/index.php',file);
			
		};

	};

	return new app();

});