(function ($) {
    var queryParser = function (a) {
        var i, p, b = {};
        if (a === "") {
            return {};
        }
        for (i = 0; i < a.length; i += 1) {
            p = a[i].split('=');
            if (p.length === 2) {
                b[p[0]] = decodeURIComponent(p[1].replace(/\+/g, " "));
            }
        }
        return b;
    };
    $.queryParams = function () {
        return queryParser(window.location.search.substr(1).split('&'));
    };
    $.hashParams = function () {
        return queryParser(window.location.hash.substr(1).split('&'));
    };


    window.Swiftype = window.Swiftype || {};
    Swiftype.root_url = Swiftype.root_url || 'https://api.swiftype.com';
    Swiftype.pingUrl = function(endpoint, callback) {
        var to = setTimeout(callback, 350);
        var img = new Image();
        img.onload = img.onerror = function() {
            clearTimeout(to);
            callback();
        };
        img.src = endpoint;
        return false;
    };
    Swiftype.pingSearchResultClick = function (engineKey, docId, callback) {
        var params = {
            t: new Date().getTime(),
            engine_key: engineKey,
            doc_id: docId,
            q: Swiftype.currentQuery
        };
        var url = Swiftype.root_url + '/api/v1/public/analytics/pc?' + $.param(params);
        Swiftype.pingUrl(url, callback);
    };

    $.fn.swiftypeSearch = function (options) {
        var options = $.extend({}, $.fn.swiftypeSearch.defaults, options);

        return this.each(function () {
            var $this = $(this);
            var config = $.meta ? $.extend({}, options, $this.data()) : options;
            $this.data('swiftype-config-search', config);

            $this.selectedCallback = function (data) {
                return function (e) {
                    var $el = $(this);
                    e.preventDefault();
                    Swiftype.pingSearchResultClick(config.engineKey, data['id'], function() {
                        window.location = $el.attr('href');
                    });
                };
            };

            $this.registerResult = function ($element, data) {
                $element.data('swiftype-item', data);
                $('a', $element).click($this.selectedCallback(data));
            };

            $this.getContentCache = function () {
                return $('#' + contentCacheId);
            };

            var $resultContainer = $(config.resultContainingElement),
                initialContentOfResultContainer = $resultContainer.html(),
                contentCacheId = 'st-content-cache',
                $contentCache = $this.getContentCache();

            var setSearchHash = function (query, page) {
                location.hash = "stq=" + encodeURIComponent(query) + "&stp=" + page;
            };

            var submitSearch = function (query, options) {
                options = $.extend({
                    page: 1
                }, options);
                var params = {};

                if (!$contentCache.length) {
                    $resultContainer.after("<div id='" + contentCacheId + "' style='display: none;'></div>");
                    $contentCache.html(initialContentOfResultContainer).hide();
                }
                config.loadingFunction(query, $resultContainer);

                Swiftype.currentQuery = query;
                params['q'] = query;
                params['engine_key'] = config.engineKey;
                params['page'] = options.page;
                params['per_page'] = config.perPage;

                function handleFunctionParam(field) {
                    if (field !== undefined) {
                        var evald = field;
                        if (typeof evald === 'function') {
                            evald = evald.call();
                        }
                        return evald;
                    }
                    return undefined;
                }

                params['search_fields'] = handleFunctionParam(config.searchFields);
                params['fetch_fields'] = handleFunctionParam(config.fetchFields);
                params['filters'] = handleFunctionParam(config.filters);
                params['document_types'] = handleFunctionParam(config.documentTypes);
                params['functional_boosts'] = handleFunctionParam(config.functionalBoosts);
                params['sort_field'] = handleFunctionParam(config.sortField);
                params['sort_direction'] = handleFunctionParam(config.sortDirection);

                $.getJSON(Swiftype.root_url + "/api/v1/public/engines/search.json?callback=?", params).success(renderSearchResults);
            };

            $(window).hashchange(function () {
                var params = $.hashParams();
                if (params.stq) {
                    submitSearch(params.stq, {
                        page: params.stp
                    });
                } else {
                    var $contentCache = $this.getContentCache();
                    if ($contentCache.length) {
                        $resultContainer.html($contentCache.html());
                        $contentCache.remove();
                    }
                }
            });

            var $containingForm = $this.parents('form');
            if ($containingForm) {
                $containingForm.bind('submit', function (e) {
                    e.preventDefault();
                    var searchQuery = $this.val();
                    setSearchHash(searchQuery, 1);
                });
            }

            $(document).on('click', '[data-hash][data-page]', function (e) {
                e.preventDefault();
                var $this = $(this);
                setSearchHash($.hashParams().stq, $this.data('page'));
            });

            var renderSearchResults = function (data) {
                if (typeof config.preRenderFunction === 'function') {
                    config.preRenderFunction.call($this, data);
                }
                config.renderResultsFunction($this.getContext(), data);
            };

            $this.getContext = function () {
                return {
                    config: config,
                    resultContainer: $resultContainer,
                    registerResult: $this.registerResult
                };
            };

            $(window).hashchange(); // if the swiftype query hash is present onload (maybe the user is pressing the back button), submit a query onload
        });
    };

    var renderPagination = function (ctx, resultInfo) {
        var maxPagesType, maxPages = -1;
        $.each(resultInfo, function(documentType, typeInfo) {
            if (typeInfo.num_pages > maxPages) {
                maxPagesType = documentType;
                maxPages = typeInfo.num_pages;
            }
        });
        var currentPage = resultInfo[maxPagesType].current_page,
            totalPages = resultInfo[maxPagesType].num_pages;
        $(renderPaginationForType(maxPagesType, currentPage, totalPages)).appendTo(ctx.resultContainer);
    };

    var renderPaginationForType = function (type, currentPage, totalPages) {
        var pages = '<div class="st-page">',
            previousPage, nextPage;
        if (currentPage != 1) {
            previousPage = currentPage - 1;
            pages = pages + '<a href="#" class="st-prev" data-hash="true" data-page="' + previousPage + '">&laquo; previous</a>';
        }
        if (currentPage < totalPages) {
            nextPage = currentPage + 1;
            pages = pages + '<a href="#" class="st-next" data-hash="true" data-page="' + nextPage + '">next &raquo;</a>';
        }
        pages += '</div>';
        return pages;
    };

    var normalize = function (str) {
        return $.trim(str).toLowerCase();
    };

    function htmlEscape(str) {
        return String(str).replace(/&/g, '&amp;').replace(/"/g, '&quot;').replace(/'/g, '&#39;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
    }

    var defaultRenderResultsFunction = function (ctx, data) {
        var $resultContainer = ctx.resultContainer,
            config = ctx.config;

        $resultContainer.html('');

        $.each(data.records, function (documentType, items) {
            $.each(items, function (idx, item) {
                ctx.registerResult($(config.renderFunction(documentType, item)).appendTo($resultContainer), item);
            });
        });

        renderPagination(ctx, data.info);
    };

    var defaultRenderFunction = function (document_type, item) {
        return '<div class="st-result"><h3 class="title"><a href="' + item['url'] + '" class="st-search-result-link">' + htmlEscape(item['title']) + '</a></h3></div>';
    };

    var defaultLoadingFunction = function(query, $resultContainer) {
        $resultContainer.html('<p class="st-loading-message">loading...</p>');
    };

    $.fn.swiftypeSearch.defaults = {
        attachTo: undefined,
        documentTypes: undefined,
        filters: undefined,
        engineKey: undefined,
        searchFields: undefined,
        functionalBoosts: undefined,
        sortField: undefined,
        sortDirection: undefined,
        fetchFields: undefined,
        preRenderFunction: undefined,
        loadingFunction: defaultLoadingFunction,
        renderResultsFunction: defaultRenderResultsFunction,
        renderFunction: defaultRenderFunction,
        perPage: 10
    };
})(jQuery);
/*================ jquery.ha-hashchange.js =============================*/
(function($,window,undefined){
    '$:nomunge'; // Used by YUI compressor.

    // Reused string.
    var str_hashchange = 'hashchange',

    // Method / object references.
        doc = document,
        fake_onhashchange,
        special = $.event.special,

    // Does the browser support window.onhashchange? Note that IE8 running in
    // IE7 compatibility mode reports true for 'onhashchange' in window, even
    // though the event isn't supported, so also test document.documentMode.
        doc_mode = doc.documentMode,
        supports_onhashchange = 'on' + str_hashchange in window && ( doc_mode === undefined || doc_mode > 7 );

    // Get location.hash (or what you'd expect location.hash to be) sans any
    // leading #. Thanks for making this necessary, Firefox!
    function get_fragment( url ) {
        url = url || location.href;
        return '#' + url.replace( /^[^#]*#?(.*)$/, '$1' );
    };

    // Method: jQuery.fn.hashchange
    //
    // Bind a handler to the window.onhashchange event or trigger all bound
    // window.onhashchange event handlers. This behavior is consistent with
    // jQuery's built-in event handlers.
    //
    // Usage:
    //
    // > jQuery(window).hashchange( [ handler ] );
    //
    // Arguments:
    //
    //  handler - (Function) Optional handler to be bound to the hashchange
    //    event. This is a "shortcut" for the more verbose form:
    //    jQuery(window).bind( 'hashchange', handler ). If handler is omitted,
    //    all bound window.onhashchange event handlers will be triggered. This
    //    is a shortcut for the more verbose
    //    jQuery(window).trigger( 'hashchange' ). These forms are described in
    //    the <hashchange event> section.
    //
    // Returns:
    //
    //  (jQuery) The initial jQuery collection of elements.

    // Allow the "shortcut" format $(elem).hashchange( fn ) for binding and
    // $(elem).hashchange() for triggering, like jQuery does for built-in events.
    $.fn[ str_hashchange ] = function( fn ) {
        return fn ? this.bind( str_hashchange, fn ) : this.trigger( str_hashchange );
    };

    // Property: jQuery.fn.hashchange.delay
    //
    // The numeric interval (in milliseconds) at which the <hashchange event>
    // polling loop executes. Defaults to 50.

    // Property: jQuery.fn.hashchange.domain
    //
    // If you're setting document.domain in your JavaScript, and you want hash
    // history to work in IE6/7, not only must this property be set, but you must
    // also set document.domain BEFORE jQuery is loaded into the page. This
    // property is only applicable if you are supporting IE6/7 (or IE8 operating
    // in "IE7 compatibility" mode).
    //
    // In addition, the <jQuery.fn.hashchange.src> property must be set to the
    // path of the included "document-domain.html" file, which can be renamed or
    // modified if necessary (note that the document.domain specified must be the
    // same in both your main JavaScript as well as in this file).
    //
    // Usage:
    //
    // jQuery.fn.hashchange.domain = document.domain;

    // Property: jQuery.fn.hashchange.src
    //
    // If, for some reason, you need to specify an Iframe src file (for example,
    // when setting document.domain as in <jQuery.fn.hashchange.domain>), you can
    // do so using this property. Note that when using this property, history
    // won't be recorded in IE6/7 until the Iframe src file loads. This property
    // is only applicable if you are supporting IE6/7 (or IE8 operating in "IE7
    // compatibility" mode).
    //
    // Usage:
    //
    // jQuery.fn.hashchange.src = 'path/to/file.html';

    $.fn[ str_hashchange ].delay = 50;
    /*
     $.fn[ str_hashchange ].domain = null;
     $.fn[ str_hashchange ].src = null;
     */

    // Event: hashchange event
    //
    // Fired when location.hash changes. In browsers that support it, the native
    // HTML5 window.onhashchange event is used, otherwise a polling loop is
    // initialized, running every <jQuery.fn.hashchange.delay> milliseconds to
    // see if the hash has changed. In IE6/7 (and IE8 operating in "IE7
    // compatibility" mode), a hidden Iframe is created to allow the back button
    // and hash-based history to work.
    //
    // Usage as described in <jQuery.fn.hashchange>:
    //
    // > // Bind an event handler.
    // > jQuery(window).hashchange( function(e) {
    // >   var hash = location.hash;
    // >   ...
    // > });
    // >
    // > // Manually trigger the event handler.
    // > jQuery(window).hashchange();
    //
    // A more verbose usage that allows for event namespacing:
    //
    // > // Bind an event handler.
    // > jQuery(window).bind( 'hashchange', function(e) {
    // >   var hash = location.hash;
    // >   ...
    // > });
    // >
    // > // Manually trigger the event handler.
    // > jQuery(window).trigger( 'hashchange' );
    //
    // Additional Notes:
    //
    // * The polling loop and Iframe are not created until at least one handler
    //   is actually bound to the 'hashchange' event.
    // * If you need the bound handler(s) to execute immediately, in cases where
    //   a location.hash exists on page load, via bookmark or page refresh for
    //   example, use jQuery(window).hashchange() or the more verbose
    //   jQuery(window).trigger( 'hashchange' ).
    // * The event can be bound before DOM ready, but since it won't be usable
    //   before then in IE6/7 (due to the necessary Iframe), recommended usage is
    //   to bind it inside a DOM ready handler.

    // Override existing $.event.special.hashchange methods (allowing this plugin
    // to be defined after jQuery BBQ in BBQ's source code).
    special[ str_hashchange ] = $.extend( special[ str_hashchange ], {

        // Called only when the first 'hashchange' event is bound to window.
        setup: function() {
            // If window.onhashchange is supported natively, there's nothing to do..
            if ( supports_onhashchange ) { return false; }

            // Otherwise, we need to create our own. And we don't want to call this
            // until the user binds to the event, just in case they never do, since it
            // will create a polling loop and possibly even a hidden Iframe.
            $( fake_onhashchange.start );
        },

        // Called only when the last 'hashchange' event is unbound from window.
        teardown: function() {
            // If window.onhashchange is supported natively, there's nothing to do..
            if ( supports_onhashchange ) { return false; }

            // Otherwise, we need to stop ours (if possible).
            $( fake_onhashchange.stop );
        }

    });

    // fake_onhashchange does all the work of triggering the window.onhashchange
    // event for browsers that don't natively support it, including creating a
    // polling loop to watch for hash changes and in IE 6/7 creating a hidden
    // Iframe to enable back and forward.
    fake_onhashchange = (function(){
        var self = {},
            timeout_id,

        // Remember the initial hash so it doesn't get triggered immediately.
            last_hash = get_fragment(),

            fn_retval = function(val){ return val; },
            history_set = fn_retval,
            history_get = fn_retval;

        // Start the polling loop.
        self.start = function() {
            timeout_id || poll();
        };

        // Stop the polling loop.
        self.stop = function() {
            timeout_id && clearTimeout( timeout_id );
            timeout_id = undefined;
        };

        // This polling loop checks every $.fn.hashchange.delay milliseconds to see
        // if location.hash has changed, and triggers the 'hashchange' event on
        // window when necessary.
        function poll() {
            var hash = get_fragment(),
                history_hash = history_get( last_hash );

            if ( hash !== last_hash ) {
                history_set( last_hash = hash, history_hash );

                $(window).trigger( str_hashchange );

            } else if ( history_hash !== last_hash ) {
                location.href = location.href.replace( /#.*/, '' ) + history_hash;
            }

            timeout_id = setTimeout( poll, $.fn[ str_hashchange ].delay );
        };

        // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
        // vvvvvvvvvvvvvvvvvvv REMOVE IF NOT SUPPORTING IE6/7/8 vvvvvvvvvvvvvvvvvvv
        // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
        /*$.browser.msie && !supports_onhashchange && (function(){
            // Not only do IE6/7 need the "magical" Iframe treatment, but so does IE8
            // when running in "IE7 compatibility" mode.

            var iframe,
                iframe_src;

            // When the event is bound and polling starts in IE 6/7, create a hidden
            // Iframe for history handling.
            self.start = function(){
                if ( !iframe ) {
                    iframe_src = $.fn[ str_hashchange ].src;
                    iframe_src = iframe_src && iframe_src + get_fragment();

                    // Create hidden Iframe. Attempt to make Iframe as hidden as possible
                    // by using techniques from http://www.paciellogroup.com/blog/?p=604.
                    iframe = $('<iframe tabindex="-1" title="empty"/>').hide()

                        // When Iframe has completely loaded, initialize the history and
                        // start polling.
                        .one( 'load', function(){
                            iframe_src || history_set( get_fragment() );
                            poll();
                        })

                        // Load Iframe src if specified, otherwise nothing.
                        .attr( 'src', iframe_src || 'javascript:0' )

                        // Append Iframe after the end of the body to prevent unnecessary
                        // initial page scrolling (yes, this works).
                        .insertAfter( 'body' )[0].contentWindow;

                    // Whenever `document.title` changes, update the Iframe's title to
                    // prettify the back/next history menu entries. Since IE sometimes
                    // errors with "Unspecified error" the very first time this is set
                    // (yes, very useful) wrap this with a try/catch block.
                    doc.onpropertychange = function(){
                        try {
                            if ( event.propertyName === 'title' ) {
                                iframe.document.title = doc.title;
                            }
                        } catch(e) {}
                    };

                }
            };

            // Override the "stop" method since an IE6/7 Iframe was created. Even
            // if there are no longer any bound event handlers, the polling loop
            // is still necessary for back/next to work at all!
            self.stop = fn_retval;

            // Get history by looking at the hidden Iframe's location.hash.
            history_get = function() {
                return get_fragment( iframe.location.href );
            };

            // Set a new history item by opening and then closing the Iframe
            // document, *then* setting its location.hash. If document.domain has
            // been set, update that as well.
            history_set = function( hash, history_hash ) {
                var iframe_doc = iframe.document,
                    domain = $.fn[ str_hashchange ].domain;

                if ( hash !== history_hash ) {
                    // Update Iframe with any initial `document.title` that might be set.
                    iframe_doc.title = doc.title;

                    // Opening the Iframe's document after it has been closed is what
                    // actually adds a history entry.
                    iframe_doc.open();

                    // Set document.domain for the Iframe document as well, if necessary.
                    domain && iframe_doc.write( '<script>document.domain="' + domain + '"</script>' );

                    iframe_doc.close();

                    // Update the Iframe's hash, for great justice.
                    iframe.location.hash = hash;
                }
            };

        })();
        // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        // ^^^^^^^^^^^^^^^^^^^ REMOVE IF NOT SUPPORTING IE6/7/8 ^^^^^^^^^^^^^^^^^^^
        // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
*/
        return self;
    })();

})(jQuery,this);

