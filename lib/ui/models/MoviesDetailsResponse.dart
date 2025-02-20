
class MoviesDetailsResponse {
  MoviesDetailsResponse({
      this.status, 
      this.statusMessage, 
      this.data, 
     });

  MoviesDetailsResponse.fromJson(dynamic json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? status;
  String? statusMessage;
  Data? data;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['status_message'] = statusMessage;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// server_time : 1739924730
/// server_timezone : "CET"
/// api_version : 2
/// execution_time : "0 ms"



/// movie_count : 65664
/// limit : 20
/// page_number : 1
/// movies : [{"id":66847,"url":"https://yts.mx/movies/dead-money-2024","imdb_code":"tt27804552","title":"Dead Money","title_english":"Dead Money","title_long":"Dead Money (2024)","slug":"dead-money-2024","year":2024,"rating":5.9,"runtime":100,"genres":["Thriller"],"summary":"","description_full":"","synopsis":"","yt_trailer_code":"csWiRxjSsr8","language":"en","mpa_rating":"","background_image":"https://yts.mx/assets/images/movies/dead_money_2024/background.jpg","background_image_original":"https://yts.mx/assets/images/movies/dead_money_2024/background.jpg","small_cover_image":"https://yts.mx/assets/images/movies/dead_money_2024/small-cover.jpg","medium_cover_image":"https://yts.mx/assets/images/movies/dead_money_2024/medium-cover.jpg","large_cover_image":"https://yts.mx/assets/images/movies/dead_money_2024/large-cover.jpg","state":"ok","torrents":[{"url":"https://yts.mx/torrent/download/48C6381E326B8E89E6D02CF6FAB9192052E3D7C7","hash":"48C6381E326B8E89E6D02CF6FAB9192052E3D7C7","quality":"720p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"927.44 MB","size_bytes":972491325,"date_uploaded":"2025-02-18 21:13:17","date_uploaded_unix":1739909597},{"url":"https://yts.mx/torrent/download/63A41B54724488B2099924C05ED78455DCDD7F10","hash":"63A41B54724488B2099924C05ED78455DCDD7F10","quality":"1080p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"5.1","seeds":0,"peers":0,"size":"1.86 GB","size_bytes":1997159793,"date_uploaded":"2025-02-18 22:15:05","date_uploaded_unix":1739913305}],"date_uploaded":"2025-02-18 21:13:17","date_uploaded_unix":1739909597},{"id":66844,"url":"https://yts.mx/movies/george-lopez-muy-catolico-2025","imdb_code":"tt35513767","title":"George Lopez: Muy Católico","title_english":"George Lopez: Muy Católico","title_long":"George Lopez: Muy Católico (2025)","slug":"george-lopez-muy-catolico-2025","year":2025,"rating":0,"runtime":50,"genres":["Comedy","Documentary"],"summary":"","description_full":"","synopsis":"","yt_trailer_code":"sSB70hy9Xp8","language":"en","mpa_rating":"","background_image":"https://yts.mx/assets/images/movies/george_lopez_muy_catolico_2025/background.jpg","background_image_original":"https://yts.mx/assets/images/movies/george_lopez_muy_catolico_2025/background.jpg","small_cover_image":"https://yts.mx/assets/images/movies/george_lopez_muy_catolico_2025/small-cover.jpg","medium_cover_image":"https://yts.mx/assets/images/movies/george_lopez_muy_catolico_2025/medium-cover.jpg","large_cover_image":"https://yts.mx/assets/images/movies/george_lopez_muy_catolico_2025/large-cover.jpg","state":"ok","torrents":[{"url":"https://yts.mx/torrent/download/08CA351C107DF780C75F6EC407FD348789B6989B","hash":"08CA351C107DF780C75F6EC407FD348789B6989B","quality":"720p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"462.5 MB","size_bytes":484966400,"date_uploaded":"2025-02-18 20:43:51","date_uploaded_unix":1739907831},{"url":"https://yts.mx/torrent/download/F35D03DBC6836AE12FA6A0CF963BCDC077EF6DDB","hash":"F35D03DBC6836AE12FA6A0CF963BCDC077EF6DDB","quality":"1080p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"5.1","seeds":0,"peers":0,"size":"948.81 MB","size_bytes":994899395,"date_uploaded":"2025-02-18 21:17:05","date_uploaded_unix":1739909825}],"date_uploaded":"2025-02-18 20:43:51","date_uploaded_unix":1739907831},{"id":66843,"url":"https://yts.mx/movies/popeyes-revenge-2025","imdb_code":"tt33362807","title":"Popeye's Revenge","title_english":"Popeye's Revenge","title_long":"Popeye's Revenge (2025)","slug":"popeyes-revenge-2025","year":2025,"rating":0,"runtime":80,"genres":["Horror"],"summary":"","description_full":"","synopsis":"","yt_trailer_code":"QBq04vWNRqU","language":"en","mpa_rating":"","background_image":"https://yts.mx/assets/images/movies/popeyes_revenge_2025/background.jpg","background_image_original":"https://yts.mx/assets/images/movies/popeyes_revenge_2025/background.jpg","small_cover_image":"https://yts.mx/assets/images/movies/popeyes_revenge_2025/small-cover.jpg","medium_cover_image":"https://yts.mx/assets/images/movies/popeyes_revenge_2025/medium-cover.jpg","large_cover_image":"https://yts.mx/assets/images/movies/popeyes_revenge_2025/large-cover.jpg","state":"ok","torrents":[{"url":"https://yts.mx/torrent/download/60D03E2748241B5359D7219E9F4263D069FD3DE5","hash":"60D03E2748241B5359D7219E9F4263D069FD3DE5","quality":"720p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"733 MB","size_bytes":768606208,"date_uploaded":"2025-02-18 20:15:35","date_uploaded_unix":1739906135},{"url":"https://yts.mx/torrent/download/13025874AF805279582C43D1C196F3B31A5429C6","hash":"13025874AF805279582C43D1C196F3B31A5429C6","quality":"1080p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"1.33 GB","size_bytes":1428076626,"date_uploaded":"2025-02-18 21:05:59","date_uploaded_unix":1739909159}],"date_uploaded":"2025-02-18 20:15:35","date_uploaded_unix":1739906135},{"id":66842,"url":"https://yts.mx/movies/the-christmas-spirit-2023","imdb_code":"tt10047464","title":"The Christmas Spirit","title_english":"The Christmas Spirit","title_long":"The Christmas Spirit (2023)","slug":"the-christmas-spirit-2023","year":2023,"rating":4.9,"runtime":85,"genres":["Comedy","Thriller"],"summary":"","description_full":"","synopsis":"","yt_trailer_code":"","language":"en","mpa_rating":"","background_image":"https://yts.mx/assets/images/movies/the_christmas_spirit_2023/background.jpg","background_image_original":"https://yts.mx/assets/images/movies/the_christmas_spirit_2023/background.jpg","small_cover_image":"https://yts.mx/assets/images/movies/the_christmas_spirit_2023/small-cover.jpg","medium_cover_image":"https://yts.mx/assets/images/movies/the_christmas_spirit_2023/medium-cover.jpg","large_cover_image":"https://yts.mx/assets/images/movies/the_christmas_spirit_2023/large-cover.jpg","state":"ok","torrents":[{"url":"https://yts.mx/torrent/download/9AA5AB5E6E4D37E6D53DD344107F82017F5D08D9","hash":"9AA5AB5E6E4D37E6D53DD344107F82017F5D08D9","quality":"720p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"813.24 MB","size_bytes":852743946,"date_uploaded":"2025-02-18 19:45:33","date_uploaded_unix":1739904333},{"url":"https://yts.mx/torrent/download/E194AF433CF611BBAFEEC126F4A5416E8694D89A","hash":"E194AF433CF611BBAFEEC126F4A5416E8694D89A","quality":"1080p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"1.48 GB","size_bytes":1589137900,"date_uploaded":"2025-02-18 20:37:35","date_uploaded_unix":1739907455}],"date_uploaded":"2025-02-18 19:45:33","date_uploaded_unix":1739904333},{"id":66841,"url":"https://yts.mx/movies/more-than-friends-2016","imdb_code":"tt6149804","title":"More Than Friends","title_english":"More Than Friends","title_long":"More Than Friends (2016)","slug":"more-than-friends-2016","year":2016,"rating":6.7,"runtime":133,"genres":["Drama","Romance"],"summary":"","description_full":"","synopsis":"","yt_trailer_code":"LtgX_PjzLGg","language":"en","mpa_rating":"","background_image":"https://yts.mx/assets/images/movies/more_than_friends_2016/background.jpg","background_image_original":"https://yts.mx/assets/images/movies/more_than_friends_2016/background.jpg","small_cover_image":"https://yts.mx/assets/images/movies/more_than_friends_2016/small-cover.jpg","medium_cover_image":"https://yts.mx/assets/images/movies/more_than_friends_2016/medium-cover.jpg","large_cover_image":"https://yts.mx/assets/images/movies/more_than_friends_2016/large-cover.jpg","state":"ok","torrents":[{"url":"https://yts.mx/torrent/download/E678E18CD2F00CF3C01A6F89D1AD5080E1E4DDC6","hash":"E678E18CD2F00CF3C01A6F89D1AD5080E1E4DDC6","quality":"720p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"1.2 GB","size_bytes":1288490189,"date_uploaded":"2025-02-18 18:57:40","date_uploaded_unix":1739901460},{"url":"https://yts.mx/torrent/download/F8F72C31F8050BB98C035F117FB881517201DA9F","hash":"F8F72C31F8050BB98C035F117FB881517201DA9F","quality":"1080p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"2.22 GB","size_bytes":2383706849,"date_uploaded":"2025-02-18 20:25:17","date_uploaded_unix":1739906717}],"date_uploaded":"2025-02-18 18:57:40","date_uploaded_unix":1739901460},{"id":66840,"url":"https://yts.mx/movies/juno-and-the-paycock-1930","imdb_code":"tt0021015","title":"Juno and the Paycock","title_english":"Juno and the Paycock","title_long":"Juno and the Paycock (1930)","slug":"juno-and-the-paycock-1930","year":1930,"rating":4.6,"runtime":85,"genres":["Comedy","Drama"],"summary":"","description_full":"","synopsis":"","yt_trailer_code":"","language":"en","mpa_rating":"","background_image":"https://yts.mx/assets/images/movies/juno_and_the_paycock_1930/background.jpg","background_image_original":"https://yts.mx/assets/images/movies/juno_and_the_paycock_1930/background.jpg","small_cover_image":"https://yts.mx/assets/images/movies/juno_and_the_paycock_1930/small-cover.jpg","medium_cover_image":"https://yts.mx/assets/images/movies/juno_and_the_paycock_1930/medium-cover.jpg","large_cover_image":"https://yts.mx/assets/images/movies/juno_and_the_paycock_1930/large-cover.jpg","state":"ok","torrents":[{"url":"https://yts.mx/torrent/download/31D742BCEDBE4282A0AB0E98A848A949B95DD8D3","hash":"31D742BCEDBE4282A0AB0E98A848A949B95DD8D3","quality":"720p","type":"bluray","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"875.18 MB","size_bytes":917692744,"date_uploaded":"2025-02-18 18:31:49","date_uploaded_unix":1739899909},{"url":"https://yts.mx/torrent/download/FCB0C159798829DDB297C9D72FFF382CB477B35C","hash":"FCB0C159798829DDB297C9D72FFF382CB477B35C","quality":"1080p","type":"bluray","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"1.59 GB","size_bytes":1707249500,"date_uploaded":"2025-02-18 19:54:28","date_uploaded_unix":1739904868}],"date_uploaded":"2025-02-18 18:31:49","date_uploaded_unix":1739899909},{"id":66839,"url":"https://yts.mx/movies/the-secret-she-kept-2016","imdb_code":"tt5733700","title":"The Secret She Kept","title_english":"The Secret She Kept","title_long":"The Secret She Kept (2016)","slug":"the-secret-she-kept-2016","year":2016,"rating":6.2,"runtime":0,"genres":["Drama"],"summary":"","description_full":"","synopsis":"","yt_trailer_code":"Gl5VP9eBL_E","language":"en","mpa_rating":"","background_image":"https://yts.mx/assets/images/movies/the_secret_she_kept_2016/background.jpg","background_image_original":"https://yts.mx/assets/images/movies/the_secret_she_kept_2016/background.jpg","small_cover_image":"https://yts.mx/assets/images/movies/the_secret_she_kept_2016/small-cover.jpg","medium_cover_image":"https://yts.mx/assets/images/movies/the_secret_she_kept_2016/medium-cover.jpg","large_cover_image":"https://yts.mx/assets/images/movies/the_secret_she_kept_2016/large-cover.jpg","state":"ok","torrents":[{"url":"https://yts.mx/torrent/download/4D365C3FCBE83E130E4E5FA75F725082A552BBEE","hash":"4D365C3FCBE83E130E4E5FA75F725082A552BBEE","quality":"720p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":93,"peers":28,"size":"770.43 MB","size_bytes":807854408,"date_uploaded":"2025-02-18 16:27:21","date_uploaded_unix":1739892441},{"url":"https://yts.mx/torrent/download/B4CF28CD2E53903F1CE5B424D159E2494A08DE61","hash":"B4CF28CD2E53903F1CE5B424D159E2494A08DE61","quality":"1080p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"1.39 GB","size_bytes":1492501135,"date_uploaded":"2025-02-18 18:43:01","date_uploaded_unix":1739900581}],"date_uploaded":"2025-02-18 16:27:21","date_uploaded_unix":1739892441},{"id":66838,"url":"https://yts.mx/movies/second-sight-2016","imdb_code":"tt5614070","title":"Second Sight","title_english":"Second Sight","title_long":"Second Sight (2016)","slug":"second-sight-2016","year":2016,"rating":6.8,"runtime":0,"genres":["Thriller"],"summary":"","description_full":"","synopsis":"","yt_trailer_code":"07XsNlbi_Sk","language":"en","mpa_rating":"","background_image":"https://yts.mx/assets/images/movies/second_sight_2016/background.jpg","background_image_original":"https://yts.mx/assets/images/movies/second_sight_2016/background.jpg","small_cover_image":"https://yts.mx/assets/images/movies/second_sight_2016/small-cover.jpg","medium_cover_image":"https://yts.mx/assets/images/movies/second_sight_2016/medium-cover.jpg","large_cover_image":"https://yts.mx/assets/images/movies/second_sight_2016/large-cover.jpg","state":"ok","torrents":[{"url":"https://yts.mx/torrent/download/DC86636C4773A43E7AD0E9D67062DF993200B720","hash":"DC86636C4773A43E7AD0E9D67062DF993200B720","quality":"720p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"754.5 MB","size_bytes":791150592,"date_uploaded":"2025-02-18 17:50:00","date_uploaded_unix":1739897400},{"url":"https://yts.mx/torrent/download/5C6E79B2C1FA36F2272041E4E3B61F986FC1DB7E","hash":"5C6E79B2C1FA36F2272041E4E3B61F986FC1DB7E","quality":"1080p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"1.37 GB","size_bytes":1471026299,"date_uploaded":"2025-02-18 18:54:55","date_uploaded_unix":1739901295}],"date_uploaded":"2025-02-18 17:50:00","date_uploaded_unix":1739897400},{"id":66837,"url":"https://yts.mx/movies/stolen-virginity-2016","imdb_code":"tt6036428","title":"Stolen Virginity","title_english":"Stolen Virginity","title_long":"Stolen Virginity (2016)","slug":"stolen-virginity-2016","year":2016,"rating":3,"runtime":95,"genres":["Drama","Romance"],"summary":"","description_full":"","synopsis":"","yt_trailer_code":"bF6dzNwmc0Q","language":"en","mpa_rating":"","background_image":"https://yts.mx/assets/images/movies/stolen_virginity_2016/background.jpg","background_image_original":"https://yts.mx/assets/images/movies/stolen_virginity_2016/background.jpg","small_cover_image":"https://yts.mx/assets/images/movies/stolen_virginity_2016/small-cover.jpg","medium_cover_image":"https://yts.mx/assets/images/movies/stolen_virginity_2016/medium-cover.jpg","large_cover_image":"https://yts.mx/assets/images/movies/stolen_virginity_2016/large-cover.jpg","state":"ok","torrents":[{"url":"https://yts.mx/torrent/download/75A6C8482CB19622F7711F78767E1BA63770C163","hash":"75A6C8482CB19622F7711F78767E1BA63770C163","quality":"720p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"955.11 MB","size_bytes":1001505423,"date_uploaded":"2025-02-18 14:11:38","date_uploaded_unix":1739884298},{"url":"https://yts.mx/torrent/download/61090DE17A1378D480CACE9264914D6D0870E9BD","hash":"61090DE17A1378D480CACE9264914D6D0870E9BD","quality":"1080p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"1.73 GB","size_bytes":1857573356,"date_uploaded":"2025-02-18 15:18:50","date_uploaded_unix":1739888330}],"date_uploaded":"2025-02-18 14:11:38","date_uploaded_unix":1739884298},{"id":66836,"url":"https://yts.mx/movies/seed-the-untold-story-2016","imdb_code":"tt5971724","title":"Seed: The Untold Story","title_english":"Seed: The Untold Story","title_long":"Seed: The Untold Story (2016)","slug":"seed-the-untold-story-2016","year":2016,"rating":7.7,"runtime":94,"genres":["Documentary"],"summary":"","description_full":"","synopsis":"","yt_trailer_code":"0GUxC_nojsU","language":"en","mpa_rating":"","background_image":"https://yts.mx/assets/images/movies/seed_the_untold_story_2016/background.jpg","background_image_original":"https://yts.mx/assets/images/movies/seed_the_untold_story_2016/background.jpg","small_cover_image":"https://yts.mx/assets/images/movies/seed_the_untold_story_2016/small-cover.jpg","medium_cover_image":"https://yts.mx/assets/images/movies/seed_the_untold_story_2016/medium-cover.jpg","large_cover_image":"https://yts.mx/assets/images/movies/seed_the_untold_story_2016/large-cover.jpg","state":"ok","torrents":[{"url":"https://yts.mx/torrent/download/1B3A8B920D82F717DA4679C4253A505FAFCD0B8F","hash":"1B3A8B920D82F717DA4679C4253A505FAFCD0B8F","quality":"720p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":78,"peers":34,"size":"870.52 MB","size_bytes":912806380,"date_uploaded":"2025-02-18 14:35:59","date_uploaded_unix":1739885759},{"url":"https://yts.mx/torrent/download/45777DA615CB889FCB09844AF828AB4A60A25A73","hash":"45777DA615CB889FCB09844AF828AB4A60A25A73","quality":"1080p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"1.58 GB","size_bytes":1696512082,"date_uploaded":"2025-02-18 15:39:51","date_uploaded_unix":1739889591}],"date_uploaded":"2025-02-18 14:35:59","date_uploaded_unix":1739885759},{"id":66835,"url":"https://yts.mx/movies/out-of-darkness-2016","imdb_code":"tt5790100","title":"Out of Darkness","title_english":"Out of Darkness","title_long":"Out of Darkness (2016)","slug":"out-of-darkness-2016","year":2016,"rating":8.8,"runtime":192,"genres":["Documentary","History"],"summary":"","description_full":"","synopsis":"","yt_trailer_code":"FN6vLVXu1bg","language":"en","mpa_rating":"","background_image":"https://yts.mx/assets/images/movies/out_of_darkness_2016/background.jpg","background_image_original":"https://yts.mx/assets/images/movies/out_of_darkness_2016/background.jpg","small_cover_image":"https://yts.mx/assets/images/movies/out_of_darkness_2016/small-cover.jpg","medium_cover_image":"https://yts.mx/assets/images/movies/out_of_darkness_2016/medium-cover.jpg","large_cover_image":"https://yts.mx/assets/images/movies/out_of_darkness_2016/large-cover.jpg","state":"ok","torrents":[{"url":"https://yts.mx/torrent/download/1B25204E86A49909B846A0141961BD4ACD03B8CA","hash":"1B25204E86A49909B846A0141961BD4ACD03B8CA","quality":"720p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":58,"peers":45,"size":"1.73 GB","size_bytes":1857573356,"date_uploaded":"2025-02-18 15:23:52","date_uploaded_unix":1739888632},{"url":"https://yts.mx/torrent/download/A695DC17C05A3D56441BDEA444E7E0076ADB9E29","hash":"A695DC17C05A3D56441BDEA444E7E0076ADB9E29","quality":"1080p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"3.21 GB","size_bytes":3446711255,"date_uploaded":"2025-02-18 17:49:19","date_uploaded_unix":1739897359}],"date_uploaded":"2025-02-18 15:23:52","date_uploaded_unix":1739888632},{"id":66834,"url":"https://yts.mx/movies/no-regrets-2016","imdb_code":"tt5201246","title":"No Regrets","title_english":"No Regrets","title_long":"No Regrets (2016)","slug":"no-regrets-2016","year":2016,"rating":5.6,"runtime":88,"genres":["Comedy"],"summary":"","description_full":"","synopsis":"","yt_trailer_code":"Nbiv2wWE5C8","language":"en","mpa_rating":"","background_image":"https://yts.mx/assets/images/movies/no_regrets_2016/background.jpg","background_image_original":"https://yts.mx/assets/images/movies/no_regrets_2016/background.jpg","small_cover_image":"https://yts.mx/assets/images/movies/no_regrets_2016/small-cover.jpg","medium_cover_image":"https://yts.mx/assets/images/movies/no_regrets_2016/medium-cover.jpg","large_cover_image":"https://yts.mx/assets/images/movies/no_regrets_2016/large-cover.jpg","state":"ok","torrents":[{"url":"https://yts.mx/torrent/download/80F9441E1F3B296BA8A27D8ED5E835FA80AEC8A3","hash":"80F9441E1F3B296BA8A27D8ED5E835FA80AEC8A3","quality":"720p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"807.93 MB","size_bytes":847176008,"date_uploaded":"2025-02-18 13:11:04","date_uploaded_unix":1739880664},{"url":"https://yts.mx/torrent/download/C5F2DBBF5AC744B0CC380801C1328A1F38A2F75B","hash":"C5F2DBBF5AC744B0CC380801C1328A1F38A2F75B","quality":"1080p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"1.46 GB","size_bytes":1567663063,"date_uploaded":"2025-02-18 15:12:18","date_uploaded_unix":1739887938}],"date_uploaded":"2025-02-18 13:11:04","date_uploaded_unix":1739880664},{"id":66833,"url":"https://yts.mx/movies/love-and-deceit-2016","imdb_code":"tt5932966","title":"Love and Deceit","title_english":"Love and Deceit","title_long":"Love and Deceit (2016)","slug":"love-and-deceit-2016","year":2016,"rating":6.4,"runtime":109,"genres":["Drama"],"summary":"","description_full":"","synopsis":"","yt_trailer_code":"","language":"en","mpa_rating":"","background_image":"https://yts.mx/assets/images/movies/love_and_deceit_2016/background.jpg","background_image_original":"https://yts.mx/assets/images/movies/love_and_deceit_2016/background.jpg","small_cover_image":"https://yts.mx/assets/images/movies/love_and_deceit_2016/small-cover.jpg","medium_cover_image":"https://yts.mx/assets/images/movies/love_and_deceit_2016/medium-cover.jpg","large_cover_image":"https://yts.mx/assets/images/movies/love_and_deceit_2016/large-cover.jpg","state":"ok","torrents":[{"url":"https://yts.mx/torrent/download/B4D026203F9184916BC4B2FFAC49018D271F7AE9","hash":"B4D026203F9184916BC4B2FFAC49018D271F7AE9","quality":"720p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"979.11 MB","size_bytes":1026671247,"date_uploaded":"2025-02-18 12:42:37","date_uploaded_unix":1739878957},{"url":"https://yts.mx/torrent/download/CCB783EF9119B796EEFDCA045C16B409803A4EDA","hash":"CCB783EF9119B796EEFDCA045C16B409803A4EDA","quality":"1080p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"1.79 GB","size_bytes":1921997865,"date_uploaded":"2025-02-18 13:45:28","date_uploaded_unix":1739882728}],"date_uploaded":"2025-02-18 12:42:37","date_uploaded_unix":1739878957},{"id":66832,"url":"https://yts.mx/movies/my-art-2016","imdb_code":"tt5325030","title":"My Art","title_english":"My Art","title_long":"My Art (2016)","slug":"my-art-2016","year":2016,"rating":4.3,"runtime":86,"genres":["Drama"],"summary":"","description_full":"","synopsis":"","yt_trailer_code":"","language":"en","mpa_rating":"","background_image":"https://yts.mx/assets/images/movies/my_art_2016/background.jpg","background_image_original":"https://yts.mx/assets/images/movies/my_art_2016/background.jpg","small_cover_image":"https://yts.mx/assets/images/movies/my_art_2016/small-cover.jpg","medium_cover_image":"https://yts.mx/assets/images/movies/my_art_2016/medium-cover.jpg","large_cover_image":"https://yts.mx/assets/images/movies/my_art_2016/large-cover.jpg","state":"ok","torrents":[{"url":"https://yts.mx/torrent/download/44C3F60E6A706944DA9019A8496F5EF8405886A5","hash":"44C3F60E6A706944DA9019A8496F5EF8405886A5","quality":"720p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"795 MB","size_bytes":833617920,"date_uploaded":"2025-02-18 12:34:33","date_uploaded_unix":1739878473},{"url":"https://yts.mx/torrent/download/D379C4EED33125944E40B5A743BF1B77BF840A30","hash":"D379C4EED33125944E40B5A743BF1B77BF840A30","quality":"1080p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"5.1","seeds":0,"peers":0,"size":"1.59 GB","size_bytes":1707249500,"date_uploaded":"2025-02-18 13:32:40","date_uploaded_unix":1739881960}],"date_uploaded":"2025-02-18 12:34:33","date_uploaded_unix":1739878473},{"id":66829,"url":"https://yts.mx/movies/halloweed-2016","imdb_code":"tt3635788","title":"Halloweed","title_english":"Halloweed","title_long":"Halloweed (2016)","slug":"halloweed-2016","year":2016,"rating":3.6,"runtime":101,"genres":["Comedy","Horror","Thriller"],"summary":"","description_full":"","synopsis":"","yt_trailer_code":"SfafqwZgprc","language":"en","mpa_rating":"","background_image":"https://yts.mx/assets/images/movies/halloweed_2016/background.jpg","background_image_original":"https://yts.mx/assets/images/movies/halloweed_2016/background.jpg","small_cover_image":"https://yts.mx/assets/images/movies/halloweed_2016/small-cover.jpg","medium_cover_image":"https://yts.mx/assets/images/movies/halloweed_2016/medium-cover.jpg","large_cover_image":"https://yts.mx/assets/images/movies/halloweed_2016/large-cover.jpg","state":"ok","torrents":[{"url":"https://yts.mx/torrent/download/E11B13AE1544AD1705FC2C6A9FE42B3C1E7B7131","hash":"E11B13AE1544AD1705FC2C6A9FE42B3C1E7B7131","quality":"720p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"934.08 MB","size_bytes":979453870,"date_uploaded":"2025-02-18 12:59:17","date_uploaded_unix":1739879957},{"url":"https://yts.mx/torrent/download/0C11EF2EBC3B035C3201D494D6544A2FDABDE6D9","hash":"0C11EF2EBC3B035C3201D494D6544A2FDABDE6D9","quality":"1080p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":90,"peers":64,"size":"1.69 GB","size_bytes":1814623683,"date_uploaded":"2025-02-18 13:59:32","date_uploaded_unix":1739883572}],"date_uploaded":"2025-02-18 12:59:17","date_uploaded_unix":1739879957},{"id":66828,"url":"https://yts.mx/movies/how-to-build-a-human-2016","imdb_code":"tt6195794","title":"How to Build a Human","title_english":"How to Build a Human","title_long":"How to Build a Human (2016)","slug":"how-to-build-a-human-2016","year":2016,"rating":7.8,"runtime":60,"genres":["Documentary"],"summary":"","description_full":"","synopsis":"","yt_trailer_code":"","language":"en","mpa_rating":"","background_image":"https://yts.mx/assets/images/movies/how_to_build_a_human_2016/background.jpg","background_image_original":"https://yts.mx/assets/images/movies/how_to_build_a_human_2016/background.jpg","small_cover_image":"https://yts.mx/assets/images/movies/how_to_build_a_human_2016/small-cover.jpg","medium_cover_image":"https://yts.mx/assets/images/movies/how_to_build_a_human_2016/medium-cover.jpg","large_cover_image":"https://yts.mx/assets/images/movies/how_to_build_a_human_2016/large-cover.jpg","state":"ok","torrents":[{"url":"https://yts.mx/torrent/download/D4501EE10924309D1B6777BE56C5AEF12C8A50F5","hash":"D4501EE10924309D1B6777BE56C5AEF12C8A50F5","quality":"720p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"425.29 MB","size_bytes":445948887,"date_uploaded":"2025-02-18 13:27:46","date_uploaded_unix":1739881666},{"url":"https://yts.mx/torrent/download/646C15444F6CFE1AC54017FD9256074721753EC6","hash":"646C15444F6CFE1AC54017FD9256074721753EC6","quality":"1080p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"788.12 MB","size_bytes":826403717,"date_uploaded":"2025-02-18 14:06:15","date_uploaded_unix":1739883975}],"date_uploaded":"2025-02-18 13:27:46","date_uploaded_unix":1739881666},{"id":66827,"url":"https://yts.mx/movies/fashionista-2016","imdb_code":"tt5667052","title":"Fashionista","title_english":"Fashionista","title_long":"Fashionista (2016)","slug":"fashionista-2016","year":2016,"rating":5.4,"runtime":110,"genres":["Drama","Fantasy","Thriller"],"summary":"","description_full":"","synopsis":"","yt_trailer_code":"sd0WHJX3-pE","language":"en","mpa_rating":"","background_image":"https://yts.mx/assets/images/movies/fashionista_2016/background.jpg","background_image_original":"https://yts.mx/assets/images/movies/fashionista_2016/background.jpg","small_cover_image":"https://yts.mx/assets/images/movies/fashionista_2016/small-cover.jpg","medium_cover_image":"https://yts.mx/assets/images/movies/fashionista_2016/medium-cover.jpg","large_cover_image":"https://yts.mx/assets/images/movies/fashionista_2016/large-cover.jpg","state":"ok","torrents":[{"url":"https://yts.mx/torrent/download/10CF7554832CE2BA6BC9EF66EFF24B1AEC530C47","hash":"10CF7554832CE2BA6BC9EF66EFF24B1AEC530C47","quality":"720p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":99,"peers":25,"size":"997.35 MB","size_bytes":1045797274,"date_uploaded":"2025-02-18 11:36:16","date_uploaded_unix":1739874976},{"url":"https://yts.mx/torrent/download/0878917AC7F869E8CCF714BF2E5FAE649D00296F","hash":"0878917AC7F869E8CCF714BF2E5FAE649D00296F","quality":"1080p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"5.1","seeds":100,"peers":65,"size":"2 GB","size_bytes":2147483648,"date_uploaded":"2025-02-18 13:06:19","date_uploaded_unix":1739880379}],"date_uploaded":"2025-02-18 11:36:16","date_uploaded_unix":1739874976},{"id":66826,"url":"https://yts.mx/movies/we-beat-the-dream-team-2025","imdb_code":"tt35669835","title":"We Beat the Dream Team","title_english":"We Beat the Dream Team","title_long":"We Beat the Dream Team (2025)","slug":"we-beat-the-dream-team-2025","year":2025,"rating":7,"runtime":80,"genres":["Documentary","Sport"],"summary":"","description_full":"","synopsis":"","yt_trailer_code":"q2UxAKQPcbk","language":"en","mpa_rating":"","background_image":"https://yts.mx/assets/images/movies/we_beat_the_dream_team_2025/background.jpg","background_image_original":"https://yts.mx/assets/images/movies/we_beat_the_dream_team_2025/background.jpg","small_cover_image":"https://yts.mx/assets/images/movies/we_beat_the_dream_team_2025/small-cover.jpg","medium_cover_image":"https://yts.mx/assets/images/movies/we_beat_the_dream_team_2025/medium-cover.jpg","large_cover_image":"https://yts.mx/assets/images/movies/we_beat_the_dream_team_2025/large-cover.jpg","state":"ok","torrents":[{"url":"https://yts.mx/torrent/download/D173F8CEB8B5FB773205CE2203C1D990241B4C40","hash":"D173F8CEB8B5FB773205CE2203C1D990241B4C40","quality":"720p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"731.55 MB","size_bytes":767085773,"date_uploaded":"2025-02-18 11:21:33","date_uploaded_unix":1739874093},{"url":"https://yts.mx/torrent/download/534E6829F4A95478F9DEBD4F8C9DF9A18AD1ADE4","hash":"534E6829F4A95478F9DEBD4F8C9DF9A18AD1ADE4","quality":"1080p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"5.1","seeds":100,"peers":55,"size":"1.46 GB","size_bytes":1567663063,"date_uploaded":"2025-02-18 12:23:44","date_uploaded_unix":1739877824}],"date_uploaded":"2025-02-18 11:21:33","date_uploaded_unix":1739874093},{"id":66825,"url":"https://yts.mx/movies/rosebud-baker-the-mother-lode-2025","imdb_code":"tt35510818","title":"Rosebud Baker: The Mother Lode","title_english":"Rosebud Baker: The Mother Lode","title_long":"Rosebud Baker: The Mother Lode (2025)","slug":"rosebud-baker-the-mother-lode-2025","year":2025,"rating":0,"runtime":54,"genres":["Comedy","Documentary"],"summary":"","description_full":"","synopsis":"","yt_trailer_code":"","language":"en","mpa_rating":"","background_image":"https://yts.mx/assets/images/movies/rosebud_baker_the_mother_lode_2025/background.jpg","background_image_original":"https://yts.mx/assets/images/movies/rosebud_baker_the_mother_lode_2025/background.jpg","small_cover_image":"https://yts.mx/assets/images/movies/rosebud_baker_the_mother_lode_2025/small-cover.jpg","medium_cover_image":"https://yts.mx/assets/images/movies/rosebud_baker_the_mother_lode_2025/medium-cover.jpg","large_cover_image":"https://yts.mx/assets/images/movies/rosebud_baker_the_mother_lode_2025/large-cover.jpg","state":"ok","torrents":[{"url":"https://yts.mx/torrent/download/BC0FBD8AF4CE5D60698282C17646A658B10789E5","hash":"BC0FBD8AF4CE5D60698282C17646A658B10789E5","quality":"720p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"505.87 MB","size_bytes":530443141,"date_uploaded":"2025-02-18 09:59:19","date_uploaded_unix":1739869159},{"url":"https://yts.mx/torrent/download/FA1B1B687A2112B2A8888AEC592CDF0F87315A90","hash":"FA1B1B687A2112B2A8888AEC592CDF0F87315A90","quality":"1080p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"5.1","seeds":0,"peers":0,"size":"1.01 GB","size_bytes":1084479242,"date_uploaded":"2025-02-18 10:43:18","date_uploaded_unix":1739871798}],"date_uploaded":"2025-02-18 09:59:19","date_uploaded_unix":1739869159},{"id":66824,"url":"https://yts.mx/movies/seeing-the-beginning-of-time-2017","imdb_code":"tt10553756","title":"Seeing the Beginning of Time","title_english":"Seeing the Beginning of Time","title_long":"Seeing the Beginning of Time (2017)","slug":"seeing-the-beginning-of-time-2017","year":2017,"rating":7.3,"runtime":47,"genres":["Documentary"],"summary":"","description_full":"","synopsis":"","yt_trailer_code":"","language":"ru","mpa_rating":"","background_image":"https://yts.mx/assets/images/movies/seeing_the_beginning_of_time_2017/background.jpg","background_image_original":"https://yts.mx/assets/images/movies/seeing_the_beginning_of_time_2017/background.jpg","small_cover_image":"https://yts.mx/assets/images/movies/seeing_the_beginning_of_time_2017/small-cover.jpg","medium_cover_image":"https://yts.mx/assets/images/movies/seeing_the_beginning_of_time_2017/medium-cover.jpg","large_cover_image":"https://yts.mx/assets/images/movies/seeing_the_beginning_of_time_2017/large-cover.jpg","state":"ok","torrents":[{"url":"https://yts.mx/torrent/download/DF0511A0F9FA7DD450924A3608E69DD134308081","hash":"DF0511A0F9FA7DD450924A3608E69DD134308081","quality":"720p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"442.78 MB","size_bytes":464288481,"date_uploaded":"2025-02-18 07:17:58","date_uploaded_unix":1739859478},{"url":"https://yts.mx/torrent/download/90289F151863EFF25A4CC6731566B9923A5F180F","hash":"90289F151863EFF25A4CC6731566B9923A5F180F","quality":"1080p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"820.21 MB","size_bytes":860052521,"date_uploaded":"2025-02-18 07:51:48","date_uploaded_unix":1739861508}],"date_uploaded":"2025-02-18 07:17:58","date_uploaded_unix":1739859478}]

class Data {
  Data({
      this.movieCount, 
      this.limit, 
      this.pageNumber, 
      this.movie,});

  Data.fromJson(dynamic json) {
    movieCount = json['movie_count'];
    limit = json['limit'];
    pageNumber = json['page_number'];
    if (json['movies'] != null) {
      movie = [];
      json['movies'].forEach((v) {
        movie?.add(Movie.fromJson(v));
      });
    }
  }
  int? movieCount;
  int? limit;
  int? pageNumber;
  List<Movie>? movie;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['movie_count'] = movieCount;
    map['limit'] = limit;
    map['page_number'] = pageNumber;
    if (movie != null) {
      map['movies'] = movie?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 66847
/// url : "https://yts.mx/movies/dead-money-2024"
/// imdb_code : "tt27804552"
/// title : "Dead Money"
/// title_english : "Dead Money"
/// title_long : "Dead Money (2024)"
/// slug : "dead-money-2024"
/// year : 2024
/// rating : 5.9
/// runtime : 100
/// genres : ["Thriller"]
/// summary : ""
/// description_full : ""
/// synopsis : ""
/// yt_trailer_code : "csWiRxjSsr8"
/// language : "en"
/// mpa_rating : ""
/// background_image : "https://yts.mx/assets/images/movies/dead_money_2024/background.jpg"
/// background_image_original : "https://yts.mx/assets/images/movies/dead_money_2024/background.jpg"
/// small_cover_image : "https://yts.mx/assets/images/movies/dead_money_2024/small-cover.jpg"
/// medium_cover_image : "https://yts.mx/assets/images/movies/dead_money_2024/medium-cover.jpg"
/// large_cover_image : "https://yts.mx/assets/images/movies/dead_money_2024/large-cover.jpg"
/// state : "ok"
/// torrents : [{"url":"https://yts.mx/torrent/download/48C6381E326B8E89E6D02CF6FAB9192052E3D7C7","hash":"48C6381E326B8E89E6D02CF6FAB9192052E3D7C7","quality":"720p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"927.44 MB","size_bytes":972491325,"date_uploaded":"2025-02-18 21:13:17","date_uploaded_unix":1739909597},{"url":"https://yts.mx/torrent/download/63A41B54724488B2099924C05ED78455DCDD7F10","hash":"63A41B54724488B2099924C05ED78455DCDD7F10","quality":"1080p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"5.1","seeds":0,"peers":0,"size":"1.86 GB","size_bytes":1997159793,"date_uploaded":"2025-02-18 22:15:05","date_uploaded_unix":1739913305}]
/// date_uploaded : "2025-02-18 21:13:17"
/// date_uploaded_unix : 1739909597

class Movie {
  Movie({
      this.id, 
      this.url, 
      this.imdbCode, 
      this.title, 
      this.titleEnglish, 
      this.titleLong, 
      this.slug, 
      this.year, 
      this.rating, 
      this.runtime, 
      this.genres, 
      this.summary, 
      this.descriptionFull, 
      this.synopsis, 
      this.ytTrailerCode, 
      this.language, 
      this.mpaRating, 
      this.backgroundImage, 
      this.backgroundImageOriginal, 
      this.smallCoverImage, 
      this.mediumCoverImage, 
      this.largeCoverImage, 
      this.state, 
      this.torrents, 
      this.dateUploaded, 
      this.dateUploadedUnix,});

  Movie.fromJson(dynamic json) {
    id = json['id'];
    url = json['url'];
    imdbCode = json['imdb_code'];
    title = json['title'];
    titleEnglish = json['title_english'];
    titleLong = json['title_long'];
    slug = json['slug'];
    year = json['year'];
    rating = json['rating'];
    runtime = json['runtime'];
    genres = json['genres'] != null ? json['genres'].cast<String>() : [];
    summary = json['summary'];
    descriptionFull = json['description_full'];
    synopsis = json['synopsis'];
    ytTrailerCode = json['yt_trailer_code'];
    language = json['language'];
    mpaRating = json['mpa_rating'];
    backgroundImage = json['background_image'];
    backgroundImageOriginal = json['background_image_original'];
    smallCoverImage = json['small_cover_image'];
    mediumCoverImage = json['medium_cover_image'];
    largeCoverImage = json['large_cover_image'];
    state = json['state'];
    if (json['torrents'] != null) {
      torrents = [];
      json['torrents'].forEach((v) {
        torrents?.add(Torrents.fromJson(v));
      });
    }
    dateUploaded = json['date_uploaded'];
    dateUploadedUnix = json['date_uploaded_unix'];
  }
  int? id;
  String? url;
  String? imdbCode;
  String? title;
  String? titleEnglish;
  String? titleLong;
  String? slug;
  int? year;
  double? rating;
  int? runtime;
  List<String>? genres;
  String? summary;
  String? descriptionFull;
  String? synopsis;
  String? ytTrailerCode;
  String? language;
  String? mpaRating;
  String? backgroundImage;
  String? backgroundImageOriginal;
  String? smallCoverImage;
  String? mediumCoverImage;
  String? largeCoverImage;
  String? state;
  List<Torrents>? torrents;
  String? dateUploaded;
  int? dateUploadedUnix;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['url'] = url;
    map['imdb_code'] = imdbCode;
    map['title'] = title;
    map['title_english'] = titleEnglish;
    map['title_long'] = titleLong;
    map['slug'] = slug;
    map['year'] = year;
    map['rating'] = rating;
    map['runtime'] = runtime;
    map['genres'] = genres;
    map['summary'] = summary;
    map['description_full'] = descriptionFull;
    map['synopsis'] = synopsis;
    map['yt_trailer_code'] = ytTrailerCode;
    map['language'] = language;
    map['mpa_rating'] = mpaRating;
    map['background_image'] = backgroundImage;
    map['background_image_original'] = backgroundImageOriginal;
    map['small_cover_image'] = smallCoverImage;
    map['medium_cover_image'] = mediumCoverImage;
    map['large_cover_image'] = largeCoverImage;
    map['state'] = state;
    if (torrents != null) {
      map['torrents'] = torrents?.map((v) => v.toJson()).toList();
    }
    map['date_uploaded'] = dateUploaded;
    map['date_uploaded_unix'] = dateUploadedUnix;
    return map;
  }

}

/// url : "https://yts.mx/torrent/download/48C6381E326B8E89E6D02CF6FAB9192052E3D7C7"
/// hash : "48C6381E326B8E89E6D02CF6FAB9192052E3D7C7"
/// quality : "720p"
/// type : "web"
/// is_repack : "0"
/// video_codec : "x264"
/// bit_depth : "8"
/// audio_channels : "2.0"
/// seeds : 0
/// peers : 0
/// size : "927.44 MB"
/// size_bytes : 972491325
/// date_uploaded : "2025-02-18 21:13:17"
/// date_uploaded_unix : 1739909597

class Torrents {
  Torrents({
      this.url, 
      this.hash, 
      this.quality, 
      this.type, 
      this.isRepack, 
      this.videoCodec, 
      this.bitDepth, 
      this.audioChannels, 
      this.seeds, 
      this.peers, 
      this.size, 
      this.sizeBytes, 
      this.dateUploaded, 
      this.dateUploadedUnix,});

  Torrents.fromJson(dynamic json) {
    url = json['url'];
    hash = json['hash'];
    quality = json['quality'];
    type = json['type'];
    isRepack = json['is_repack'];
    videoCodec = json['video_codec'];
    bitDepth = json['bit_depth'];
    audioChannels = json['audio_channels'];
    seeds = json['seeds'];
    peers = json['peers'];
    size = json['size'];
    sizeBytes = json['size_bytes'];
    dateUploaded = json['date_uploaded'];
    dateUploadedUnix = json['date_uploaded_unix'];
  }
  String? url;
  String? hash;
  String? quality;
  String? type;
  String? isRepack;
  String? videoCodec;
  String? bitDepth;
  String? audioChannels;
  int? seeds;
  int? peers;
  String? size;
  int? sizeBytes;
  String? dateUploaded;
  int? dateUploadedUnix;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['hash'] = hash;
    map['quality'] = quality;
    map['type'] = type;
    map['is_repack'] = isRepack;
    map['video_codec'] = videoCodec;
    map['bit_depth'] = bitDepth;
    map['audio_channels'] = audioChannels;
    map['seeds'] = seeds;
    map['peers'] = peers;
    map['size'] = size;
    map['size_bytes'] = sizeBytes;
    map['date_uploaded'] = dateUploaded;
    map['date_uploaded_unix'] = dateUploadedUnix;
    return map;
  }

}