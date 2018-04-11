var app = angular.module('dashboard',['account-module','notifications-module']);

app.controller('dashboardCtrl',function($scope) {
	
	$scope.module = {
		id: 'dashboard',
		privileges: {

		}
	};
	
});