angular.module('app-module', ['form-validator','bootstrap-modal','ui.bootstrap','ngRoute']).config(function($routeProvider) {
    $routeProvider
        .when('/:option/:id', {
            templateUrl: 'groups-add.html'
        })
		
}).factory('app', function($http,$timeout,$window,$routeParams,$location,validate,bootstrapModal) {
	
	function app() {

		var self = this;

		self.startup = function(scope) {
			
			
			scope.controls.add = true;
			scope.controls.edit = false;	
			
			scope.$on('$routeChangeSuccess', function() {
				
				switch ($routeParams.option) {
					
					case 'view':
					
						if ($routeParams.id != undefined) {					
							self.load(scope,$routeParams.id);
							scope.controls.add = false;
							scope.controls.edit = true;
						};					
					
					break;
					
					case 'delete':
					
						if ($routeParams.id != undefined) {					
							self.load(scope,$routeParams.id);
							scope.controls.add = false;
							scope.controls.edit = false;
							scope.controls.ok=false;
							scope.controls.cancel=false;
							self.deleteConfirm(scope,$routeParams.id);
						};
							
					break;
					
				};				

			});				
			
		};
		
		self.data = function(scope) {

			scope.formHolder = {};
			scope.views = {};
			
			scope.controls = {
				btns: {
					ok: true,
					cancel: true
				},
				add: true,
				edit: true,
				ok: true,
				cancel:true
			};
			
			scope.groups = {};
			scope.groups.id = 0;	
			
			scope.groups = [];
			
			scope.views.currentPage = 1;	

		};
		
		self.add = function(scope) {
			
			scope.groups.id = 0;
			
			scope.controls.btns.ok = false;
			scope.controls.btns.cancel = false;
			
		};
		
		self.cancel = function(scope) {
			
			scope.controls.btns.ok = true;
			scope.controls.btns.cancel = true;
			
			validate.cancel(scope,'groups');
			
			$timeout(function() {
				if ($routeParams.option==undefined) scope.groups = {};				
			},500);
			
		};
		
		self.view = function(scope,row) {
			
			$window.location.href = "groups-add.html#!/view/"+row.id;
			
		};
		self.delete = function(scope,row){
			
			scope.views.currentPage = scope.currentPage;
			
			$window.location.href = "groups-add.html#!/delete/"+row.id;
			
		};
		
		self.deleteConfirm = function(scope,id) {
			
			var onOk = function() {
				
				$http({
					method: 'POST',
					url: 'handlers/groups-delete.php',
					data: {id: id}
				}).then(function mySuccess(response) {
					
						$window.location.href = "groups-list.html";
						
				}, function myError(response) {
			
			
			
				});

			};
			
			var onCancel = function() {
				
				$window.location.href = "groups-list.html";
				
			};
			
			bootstrapModal.confirm(scope,'Confirmation','Are you sure you want to Delete?',onOk,onCancel);
				
		};
		
		self.edit = function(scope) {
			
			scope.controls.btns.ok = false;
			scope.controls.btns.cancel = false;			
			
		};
		
		self.load = function(scope,id) {
			
			$http({
			  method: 'POST',
			  url: 'handlers/groups-view.php',
			  data: {id: id}
			}).then(function mySuccess(response) {
				
				scope.groups = angular.copy(response.data);			
				
			}, function myError(response) {
				
				//
				
			});			
			
		};
		
		self.save = function(scope) {

			// validation
			if (validate.form(scope,'groups')) return;
			
			$http({
			  method: 'POST',
			  url: 'handlers/groups-save.php',
			  data: scope.groups
			}).then(function mySuccess(response) {
				
				if (scope.groups.id == 0) {
					scope.groups = {};
					scope.groups.id = 0;
				};
				scope.controls.btns.ok = true;
				scope.controls.btns.cancel = true;					
				
			}, function myError(response) {
				
				//
				
			});			
			
		};
		
		self.list = function(scope) {
			
			scope.currentPage = scope.views.currentPage; 
			scope.pageSize = 10; 
			scope.maxSize = 3; 

			$http({
			  method: 'GET',
			  url: 'handlers/groups-list.php'
			}).then(function mySuccess(response) {
				
				scope.groups = angular.copy(response.data);	

				scope.filterData = scope.groups; 
				scope.currentPage = scope.views.currentPage; 							
				
			}, function myError(response) {
				
				//
				
			});				
			
		};

	};

	return new app();

});