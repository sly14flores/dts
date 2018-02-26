var app = angular.module('groups',['account-module','app-module','ngRoute']);

app.controller('groupsCtrl',function($scope,app) {
	
	$scope.app = app;
	
	$scope.app.data($scope);
	
	$scope.app.startup($scope);	
	
});