'use strict';

console.log('outer helper register - - - - -');

(function (factory) {
	if (typeof module === 'object' && module.exports) {
		var relative_path = require('nconf').get('relative_path');
		module.exports = factory('../utils', require('benchpressjs'), relative_path);
	} else if (typeof define === 'function' && define.amd) {
		define('helpers', ['benchpress'], function (Benchpress) {
			return factory(utils, Benchpress, config.relative_path);
		});
	}
})(function (utils, Benchpress, relative_path) {
  Benchpress.registerHelper('buildAvatarMock', 	function buildAvatarMock(userObj, size, rounded, classNames, component) {
    /**
     * userObj requires:
     *   - uid, picture, icon:bgColor, icon:text (getUserField w/ "picture" should return all 4), username
     * size: one of "xs", "sm", "md", "lg", or "xl" (required), or an integer
     * rounded: true or false (optional, default false)
     * classNames: additional class names to prepend (optional, default none)
     * component: overrides the default component (optional, default none)
     */

    var attributes = [
      'alt="' + userObj.username + '"',
      'title="' + userObj.username + '"',
      'data-uid="' + userObj.uid + '"',
      'loading="lazy"',
    ];
    var styles = [];
    classNames = classNames || '';

    // Validate sizes, handle integers, otherwise fall back to `avatar-sm`
    if (['xs', 'sm', 'sm2x', 'md', 'lg', 'xl'].includes(size)) {
      classNames += ' avatar-' + size;
    } else if (!isNaN(parseInt(size, 10))) {
      styles.push('width: ' + size + 'px;', 'height: ' + size + 'px;', 'line-height: ' + size + 'px;', 'font-size: ' + (parseInt(size, 10) / 16) + 'rem;');
    } else {
      classNames += ' avatar-sm';
    }
    attributes.unshift('class="avatar ' + classNames + (rounded ? ' avatar-rounded' : '') + ' test-helpers"');

    // Component override
    if (component) {
      attributes.push('component="' + component + '"');
    } else {
      attributes.push('component="avatar/' + (userObj.picture ? 'picture' : 'icon') + '"');
    }

    if (userObj.picture) {
      userObj.picture = userObj.picture.replace(/^http\:/, 'https:');
      return '<img ' + attributes.join(' ') + ' src="' + userObj.picture + '" style="' + styles.join(' ') + '" />';
    }

    styles.push('background-color: ' + userObj['icon:bgColor'] + ';');
    return '<span ' + attributes.join(' ') + ' style="' + styles.join(' ') + '">' + userObj['icon:text'] + '</span>';
  });
});
