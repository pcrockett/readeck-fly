exports.isActive = function () {
  const matches = $.url.match(
    /^https:\/\/github.com\/[a-z-_]+\/[a-z-_]+\/?$/gi,
  );
  return Array.isArray(matches) && matches.length > 0;
};

/**
 * @param {Config} config
 */
exports.setConfig = function (config) {
  config.bodySelectors = ["article.entry-content"];
};
