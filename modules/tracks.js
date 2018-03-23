angular.module('app-module', ['form-validator','bootstrap-modal']).factory('app', function($http,$timeout,$window,validate,bootstrapModal) {
	
	function app() {

		var self = this;
		
		self.data = function(scope) {

			scope.formHolder = {};
			
			scope.views = {};

			scope.documents = [];	

		};

		self.track = function(scope) {
			
			// track-document.php
			
			var loading = '<div class="col-lg-12">Fetching document tracks please wait...</div>';
			
			$('#track').html(loading);
			
			$('#track').load('html/tracks.html');
			
		};

	};

	return new app();

});