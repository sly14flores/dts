var app = angular.module('maintenanceTransacList',['account-module','app-module']);

app.controller('maintenanceTransacCtrl',function($scope,app) {
	
	$scope.app = app;
	
	$scope.app.data($scope);

	$scope.app.list($scope);

});