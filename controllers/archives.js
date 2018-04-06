var app = angular.module('archives',['account-module','app-module']);

app.controller('archivesCtrl',function($scope,app) {
	
	$scope.app = app;
	
	$scope.app.data($scope);

	$scope.app.list($scope);
	
});