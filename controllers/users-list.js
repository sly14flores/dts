var app = angular.module('profileList',['account-module','app-module']);

app.controller('profileListCtrl',function($scope,app) {
	
	$scope.app = app;
	
	$scope.app.data($scope);

	$scope.app.list($scope);
	
});