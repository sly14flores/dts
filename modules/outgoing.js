angular.module('app-module', ['bootstrap-modal','ui.bootstrap','window-open-post','notifications-module','ngRoute']).config(function($routeProvider) {
    $routeProvider.when('/:option/:id', {
        templateUrl: 'outgoing.html'
    });	
}).factory('app', function($http,$timeout,$window,$routeParams,$location,bootstrapModal,printPost) {
	
	function app() {

		var self = this;
		
		self.data = function(scope) {

			scope.formHolder = {};
			
			scope.views = {};
			
			scope.activity = {};
			
			scope.outgoings = [];
			
			scope.views.currentPage = 1;
			
			scope.$watch(function(scope) {
				
				return scope.search;
				
			},function(newValue, oldValue) {
				
				$timeout(function() { $('[data-toggle="tooltip"]').tooltip(); },500);
				
			});

			scope.$on('$routeChangeSuccess', function() {

				if ($routeParams.option != undefined) {
					
					if ($routeParams.id != undefined) {
						
						$timeout(function() {
							
							$http({
							  method: 'POST',
							  url: 'handlers/outgoing.php',
							  data: {id: $routeParams.id}
							}).then(function mySuccess(response) {

								self.tracks(scope,response.data);

							}, function myError(response) {
								
							});								
							
						}, 1000);

					};
					
				};			

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

			scope.activity.next = {};
			offices(scope);

			scope.staffs = [];	
			
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

				return true;

			};

			if (outgoing.document_tracks_status == 'for_pick_up') bootstrapModal.box2(scope,title,'dialogs/outgoing-tracks.html',onOk);
			else bootstrapModal.box3(scope,title,'dialogs/outgoing-tracks.html',onOk);

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

	};
	
	return new app();
	
});