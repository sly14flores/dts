var app = angular.module('document',['account-module','app-module','ngRoute']);

app.controller('documentCtrl',function($scope,app) {
	
	$scope.app = app;
	
	$scope.app.data($scope);
	
	$scope.app.startup($scope);	
	
});