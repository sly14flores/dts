var app = angular.module('documentList',['account-module','app-module']);

app.controller('documentListCtrl',function($scope,app) {
	
	$scope.app = app;
	
	$scope.app.data($scope);

	$scope.app.list($scope);
	
});