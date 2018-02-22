var app = angular.module('profile',['account-module','app-module','ngRoute']);

app.controller('profileCtrl',function($scope,app) {
	
	$scope.app = app;
	
	$scope.app.data($scope);
	
	$scope.app.startup($scope);	
	
});