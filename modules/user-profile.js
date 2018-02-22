angular.module('app-module', ['form-validator','bootstrap-modal','ngRoute']).config(function($routeProvider) {
    $routeProvider
        .when('/:option/:id', {
            templateUrl: 'user-profile.html'
        })
        .when('/:option/:id', {
            templateUrl: 'user-profile.html'
        });		
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
			
			scope.user = {};
			scope.user.id = 0;	
			
			scope.users = [];
			
			scope.offices = [];
			
			$http({
				method: 'GET',
				url: 'handlers/offices.php'
			}).then(function mySuccess(response) {
				
				scope.offices = angular.copy(response.data);
					
			}, function myError(response) {
		
		
		
			});			

		};
		
		self.add = function(scope) {
			
			scope.controls.btns.ok = false;
			scope.controls.btns.cancel = false;
			
		};
		
		self.cancel = function(scope) {
			
			scope.controls.btns.ok = true;
			scope.controls.btns.cancel = true;
			
			validate.cancel(scope,'user');
			
			$timeout(function() {
				if ($routeParams.option==undefined) scope.user = {};				
			},500);
			
		};
		
		self.view = function(scope,row) {
			
			$window.location.href = "user-profile.html#!/view/"+row.id;
			
		};
		self.delete = function(scope,row){
			
			$window.location.href = "user-profile.html#!/delete/"+row.id;
			
		};
		
		self.deleteConfirm = function(scope,id) {
			
			var onOk = function() {
				
				$http({
					method: 'POST',
					url: 'handlers/profile-delete.php',
					data: {id: id}
				}).then(function mySuccess(response) {
					
						$window.location.href = "users-list.html";
						
				}, function myError(response) {
			
			
			
				});

			};
			
			var onCancel = function() {
				
				$window.location.href = "users-list.html";
				
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
			  url: 'handlers/user-view.php',
			  data: {id: id}
			}).then(function mySuccess(response) {
				
				scope.user = angular.copy(response.data);			
				
			}, function myError(response) {
				
				//
				
			});			
			
		};
		
		self.save = function(scope) {

			// validation
			if (validate.form(scope,'user')) return;
			
			$http({
			  method: 'POST',
			  url: 'handlers/profile-save.php',
			  data: scope.user
			}).then(function mySuccess(response) {
				
				if (scope.user.id == 0) {
					scope.user = {};
					scope.user.id = 0;
				};
				scope.controls.btns.ok = true;
				scope.controls.btns.cancel = true;					
				
			}, function myError(response) {
				
				//
				
			});			
			
		};
		
		self.list = function(scope) {

			$http({
			  method: 'GET',
			  url: 'handlers/users-list.php'
			}).then(function mySuccess(response) {
				
				scope.users = angular.copy(response.data);			
				
			}, function myError(response) {
				
				//
				
			});				
			
		};

	};

	return new app();

});