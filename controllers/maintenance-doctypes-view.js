var app = angular.module('maintenanceDoctypeList',['account-module','app-module']);

app.controller('maintenanceDoctypeCtrl',function($scope,app) {
	
	$scope.app = app;
	
	$scope.app.data($scope);

	$scope.app.list($scope);

});