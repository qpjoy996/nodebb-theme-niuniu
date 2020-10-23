"use strict";

var path = require('path');

var meta = require.main.require('./src/meta');
var nconf = require.main.require('nconf');

var theme = module.exports;

theme.defineWidgetAreas = function(areas, callback) {
	areas = areas.concat([
    {
      'name': 'MOTD',
      'template': 'home.tpl',
      'location': 'motd'
    },
    {
      'name': 'Homepage Footer',
      'template': 'home.tpl',
      'location': 'footer'
    },
    {
      'name': 'Category Sidebar',
      'template': 'category.tpl',
      'location': 'sidebar'
    },
		{
			name: "Topic Sidebar",
			template: "topic.tpl",
			location: "sidebar"
		}
	]);

	callback(null, areas);
};

require('./source/public/src/modules/helpers.js');

theme.preinit = function(params, callback) {
	nconf.set('base_templates_path', path.join(nconf.get('themes_path'), 'nodebb-theme-niuniu/templates'));

	callback();
};

theme.init = function(params, callback) {
	var app = params.router,
		middleware = params.middleware;

	app.get('/admin/plugins/niuniu', middleware.admin.buildHeader, renderAdmin);
  app.get('/api/admin/plugins/niuniu', renderAdmin);

	callback();
};

theme.addAdminNavigation = function(header, callback) {
	header.plugins.push({
		route: '/plugins/niuniu',
		icon: 'fa-paint-brush',
		name: 'Niuniu Theme'
	});

	callback(null, header);
};

theme.getConfig = function(config, callback) {
	config.disableMasonry = !!parseInt(meta.config.disableMasonry, 10);
	callback(null, config);
};

function renderAdmin(req, res, next) {
	res.render('admin/plugins/niuniu', {});
}

module.exports = theme;
