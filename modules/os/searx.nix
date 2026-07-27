{ ... }: {
  services.searx = {
    settings = {
      server = {
        port = 8080;
        bind_address = "127.0.0.1";
        secret_key = "I_dont_need_to_keep_it_secret_as_it_only_runs_on_my_machine";
      };
      search = {
        default_lang = "zh-CN";
        ban_time_on_fail = 5;
        safe_search = 2;
        auto_complete = "google";
      };

      engines = [
        {
          name = "google";
          engine = "google";
          disabled = false;
          timeout = 5.0;
          weight = 12;
        }

        {
          name = "startpage";
          engine = "startpage";
          disabled = false;
          timeout = 5.0;
          weight = 8;
        }
        {
          name = "duckduckgo";
          engine = "duckduckgo";
          disabled = false;
          timeout = 5.0;
          weight = 6;
        }
        {
          name = "bing";
          engine = "bing";
          base_url = "https://cn.bing.com";
          disabled = false;
          timeout = 1.0;
          weight = 6;
        }

        # 拉完了
        # {
        #   name = "baidu";
        #   engine = "baidu";
        #   disabled = false;
        #   timeout = 5.0;
        #   weight = 2
        # }

        {
          name = "wikipedia";
          engine = "wikipedia";
          disabled = false;
          base_url = "https://zh.wikipedia.org/api/rest_v1/";
          timeout = 5.0;
          weight = 10;
        }
        # 拉完了
        {
          name = "baidu baike";
          engine = "baidu_baike";
          disabled = false;
          timeout = 5.0;
          weight = 5;
        }

        #

      ];

    };
  };

}
