exports.isActive = function () {
  const matches = $.url.match(
    // <https://regexr.com/8gtio>
    /^https:\/\/github.com\/[a-z-_0-9]+\/[a-z-_0-9]+\/?(\?.*)*$/gi,
  );
  return Array.isArray(matches) && matches.length > 0;
};

/**
 * @param {Config} config
 */
exports.setConfig = function (config) {
  config.bodySelectors = ["article.entry-content"];
};
