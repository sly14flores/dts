var app = angular.module('maintenanceOfficesList',['account-module','app-module']);

app.controller('maintenanceOfficesCtrl',function($scope,app) {
	
	$scope.app = app;
	
	$scope.app.data($scope);

	$scope.app.list($scope);

});