import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../../core/vendor/db/add_to_cart_dao.dart';
import '../../../core/vendor/repository/add_new_billing_address_repository.dart';
import '../../../core/vendor/repository/add_to_cart_repository.dart';
import '../../../core/vendor/repository/edit_shipping_address_repository.dart';

import '../api/ps_api_service.dart';
import '../db/all_search_result_dao.dart';
import '../db/best_choice_dao.dart';
import '../db/chat_history_dao.dart';
import '../db/common/ps_shared_preferences.dart';
import '../db/custom_product_dao.dart';
import '../db/cutomize_ui_detail_dao.dart';
import '../db/deal_option_dao.dart';
import '../db/favourite_product_dao.dart';
import '../db/follower_item_dao.dart';
import '../db/gallery_dao.dart';
import '../db/get_in_touch_dao.dart';
import '../db/history_dao.dart';
import '../db/item_condition_dao.dart';
import '../db/item_currency_dao.dart';
import '../db/item_entry_dao.dart';
import '../db/item_loacation_dao.dart';
import '../db/item_loacation_township_dao.dart';
import '../db/item_price_type_dao.dart';
import '../db/item_type_dao.dart';
import '../db/language_dao.dart';
import '../db/mobile_color_dao.dart';
import '../db/noti_dao.dart';
import '../db/offer_dao.dart';
import '../db/offline_payment_dao.dart';
import '../db/order_id_dao.dart';
import '../db/package_bought_transaction_dao.dart';
import '../db/package_dao.dart';
import '../db/paid_ad_item_dao.dart';
import '../db/phone_country_code_dao.dart';
import '../db/product_collection_dao.dart';
import '../db/product_dao.dart';
import '../db/product_map_dao.dart';
import '../db/promotion_transaction_dao.dart';
import '../db/rating_dao.dart';
import '../db/related_product_dao.dart';
import '../db/schedule_detail_dao.dart';
import '../db/schedule_header_dao.dart';
import '../db/search_category_history_dao.dart';
import '../db/search_history_dao.dart';
import '../db/search_item_history_dao.dart';
import '../db/search_result_dao.dart';
import '../db/search_subcategory_history_dao.dart';
import '../db/shipping_area_dao.dart';
import '../db/shop_dao.dart';
import '../db/shop_info_dao.dart';
import '../db/shop_map_dao.dart';
import '../db/shop_rating_dao.dart';
import '../db/transaction_detail_dao.dart';
import '../db/transaction_header_dao.dart';
import '../db/transaction_status_dao.dart';
import '../db/user_dao.dart';
import '../db/user_field_dao.dart';
import '../db/user_login_dao.dart';
import '../db/user_map_dao.dart';
import '../db/user_unread_message_dao.dart';
import '../db/vendor_branch_dao.dart';
import '../db/vendor_info_dao.dart';
import '../db/vendor_user_dao.dart';
import '../repository/Common/add_new_shipping_address_repository.dart';
import '../repository/Common/notification_repository.dart';
import '../repository/agent_repository.dart';
import '../repository/all_search_result_repository.dart';
import '../repository/app_info_repository.dart';
import '../repository/best_choice_repository.dart';
import '../repository/chat_history_repository.dart';
import '../repository/clear_all_data_repository.dart';
import '../repository/contact_us_repository.dart';
import '../repository/custom_product_repository.dart';
import '../repository/customize_ui_detail_repository.dart';
import '../repository/delete_task_repository.dart';
import '../repository/edit_billing_address_repository.dart';
import '../repository/gallery_repository.dart';
import '../repository/history_repsitory.dart';
import '../repository/item_currency_repository.dart';
import '../repository/item_entry_field_repository.dart';
import '../repository/item_location_repository.dart';
import '../repository/item_location_township_repository.dart';
import '../repository/item_paid_history_repository.dart';
import '../repository/language_repository.dart';
import '../repository/mobile_color_repository.dart';
import '../repository/noti_repository.dart';
import '../repository/offer_repository.dart';
import '../repository/offline_payment_method_repository.dart';
import '../repository/order_id_repository.dart';
import '../repository/package_bought_repository.dart';
import '../repository/package_bought_transaction_history_repository.dart';
import '../repository/paid_ad_item_repository.dart';
import '../repository/phone_country_code_repository.dart';
import '../repository/product_by_collection_id_repository.dart';
import '../repository/product_collection_repository.dart';
import '../repository/product_repository.dart';
import '../repository/promotion_transaction_repository.dart';
import '../repository/rating_repository.dart';
import '../repository/schedule_detail_repository.dart';
import '../repository/schedule_header_repository.dart';
import '../repository/search_category_history_repository.dart';
import '../repository/search_history_repository.dart';
import '../repository/search_item_history_repository.dart';
import '../repository/search_result_repository.dart';
import '../repository/search_subcategory_history_repository.dart';
import '../repository/search_user_repository.dart';
import '../repository/shipping_area_repository.dart';
import '../repository/shop_info_repository.dart';
import '../repository/shop_rating_repository.dart';
import '../repository/shop_repository.dart';
import '../repository/tansaction_detail_repository.dart';
import '../repository/token_repository.dart';
import '../repository/top_seller_repository.dart';
import '../repository/transaction_header_repository.dart';
import '../repository/transaction_status_repository.dart';
import '../repository/user_field_repository.dart';
import '../repository/user_repository.dart';
import '../repository/user_unread_message_repository.dart';
import '../repository/vendor_branch_repository.dart';
import '../repository/vendor_info_repository.dart';
import '../repository/vendor_item_bought_repository.dart';
import '../repository/vendor_paypal_token_repository.dart';
import '../repository/vendor_search_repository.dart';
import '../repository/vendor_user_repository.dart';
import '../viewobject/common/ps_value_holder.dart';

List<SingleChildWidget> providers = <SingleChildWidget>[
  ...independentProviders,
  ..._dependentProviders,
  ..._valueProviders,
];

List<SingleChildWidget> independentProviders = <SingleChildWidget>[
  Provider<PsSharedPreferences>.value(value: PsSharedPreferences.instance),
  Provider<PsApiService>.value(value: PsApiService()),
  Provider<UserMapDao>.value(value: UserMapDao.instance),
  //wrong type not contain instance
  Provider<ProductDao>.value(
      value: ProductDao.instance), //correct type with instance
  Provider<ProductMapDao>.value(value: ProductMapDao.instance),
  Provider<NotiDao>.value(value: NotiDao.instance),
  Provider<OfflinePaymentDao>.value(value: OfflinePaymentDao.instance),
  Provider<GetInTouchDao>.value(value: GetInTouchDao.instance),
  Provider<PackageDao>.value(value: PackageDao.instance),
  Provider<PackageTransactionDao>.value(value: PackageTransactionDao.instance),
  Provider<PromotionTransactionDao>.value(
      value: PromotionTransactionDao.instance),
  Provider<UserDao>.value(value: UserDao.instance),
  Provider<UserLoginDao>.value(value: UserLoginDao.instance),
  Provider<RelatedProductDao>.value(value: RelatedProductDao.instance),
  Provider<RatingDao>.value(value: RatingDao.instance),
  Provider<ItemLocationDao>.value(value: ItemLocationDao.instance),
  Provider<ItemLocationTownshipDao>.value(
      value: ItemLocationTownshipDao.instance),
  Provider<PaidAdItemDao>.value(value: PaidAdItemDao.instance),
  Provider<HistoryDao>.value(value: HistoryDao.instance),
  Provider<GalleryDao>.value(value: GalleryDao.instance),
  Provider<FavouriteProductDao>.value(value: FavouriteProductDao.instance),
  Provider<ChatHistoryDao>.value(value: ChatHistoryDao.instance),
  Provider<OfferDao>.value(value: OfferDao.instance),
  Provider<FollowerItemDao>.value(value: FollowerItemDao.instance),
  Provider<ItemTypeDao>.value(value: ItemTypeDao()),
  Provider<PhoneCountryCodeDao>.value(value: PhoneCountryCodeDao.instance),
  Provider<ItemConditionDao>.value(value: ItemConditionDao()),
  Provider<ItemPriceTypeDao>.value(value: ItemPriceTypeDao()),
  Provider<ItemCurrencyDao>.value(value: ItemCurrencyDao()),
  Provider<ItemDealOptionDao>.value(value: ItemDealOptionDao()),
  Provider<UserUnreadMessageDao>.value(value: UserUnreadMessageDao.instance),
  Provider<ItemEntryFieldDao>.value(value: ItemEntryFieldDao.instance),
  Provider<UserFieldDao>.value(value: UserFieldDao.instance),
  Provider<CustomizeUiDetailDao>.value(value: CustomizeUiDetailDao.instance),
  Provider<CProductDao>.value(value: CProductDao.instance),
  Provider<AllSearchResultDao>.value(value: AllSearchResultDao.instance),
  Provider<MobileColorDao>.value(value: MobileColorDao.instance),
  Provider<SearchCategoryHistoryDao>.value(
      value: SearchCategoryHistoryDao.instance),
  Provider<SearchSubCategoryHistoryDao>.value(
      value: SearchSubCategoryHistoryDao.instance),
  Provider<SearchItemHistoryDao>.value(value: SearchItemHistoryDao.instance),
  Provider<VendorUserDao>.value(value: VendorUserDao.instance),
  Provider<VendorBranchDao>.value(value: VendorBranchDao.instance),
 
   Provider<ShopMapDao>.value(value: ShopMapDao.instance),

  //vendorinfo
  Provider<VendorInfoDao>.value(value: VendorInfoDao.instance),

  //ecommerce
  Provider<BestChoiceDao>.value(value: BestChoiceDao.instance),
  Provider<ProductCollectionDao>.value(value: ProductCollectionDao.instance),
  Provider<ScheduleDetailDao>.value(value: ScheduleDetailDao.instance),
  Provider<ScheduleHeaderDao>.value(value: ScheduleHeaderDao.instance),
  Provider<SearchHistoryDao>.value(value: SearchHistoryDao.instance),
  Provider<SearchResultDao>.value(value: SearchResultDao.instance),
  Provider<ShippingAreaDao>.value(value: ShippingAreaDao.instance),
  Provider<ShopDao>.value(value: ShopDao.instance),
  Provider<ShopInfoDao>.value(value: ShopInfoDao.instance),
  Provider<ShopRatingDao>.value(value: ShopRatingDao.instance),
  Provider<TransactionDetailDao>.value(value: TransactionDetailDao.instance),
  Provider<TransactionHeaderDao>.value(value: TransactionHeaderDao.instance),
  Provider<TransactionStatusDao>.value(value: TransactionStatusDao.instance),
  Provider<LanguageDao>.value(value: LanguageDao.instance),
  Provider<OrderIdDao>.value(value: OrderIdDao.instance),
  Provider<AddToCartDao>.value(value: AddToCartDao.instance),




];

List<SingleChildWidget> _dependentProviders = <SingleChildWidget>[
  ProxyProvider2<PsApiService, ItemEntryFieldDao, ItemEntryFieldRepository>(
    update: (_, PsApiService apiService, ItemEntryFieldDao itemEntryFieldDao,
            ItemEntryFieldRepository? mockProductRepository) =>
        ItemEntryFieldRepository(
            psApiService: apiService, itemEntryDao: itemEntryFieldDao),
  ),

  ProxyProvider2<PsApiService, UserFieldDao, UserFieldRepository>(
    update: (_, PsApiService apiService, UserFieldDao userFieldDao,
            UserFieldRepository? mockProductRepository) =>
        UserFieldRepository(
            psApiService: apiService, userFieldDao: userFieldDao),
  ),

  ProxyProvider2<PsApiService, CProductDao, CProductRepository>(
    update: (_, PsApiService apiService, CProductDao cProductDao,
            CProductRepository? cProductRepository) =>
        CProductRepository(apiService: apiService, cProductDao: cProductDao),
  ),

  ProxyProvider2<PsApiService, CustomizeUiDetailDao,
      CustomizeUiDetailRepository>(
    update: (_,
            PsApiService apiService,
            CustomizeUiDetailDao customizeUiDetailDao,
            CustomizeUiDetailRepository? customizeUiDetailRepository) =>
        CustomizeUiDetailRepository(
            apiService: apiService, customizeUiDetailDao: customizeUiDetailDao),
  ),
  ProxyProvider<PsApiService, AppInfoRepository>(
    update:
        (_, PsApiService psApiService, AppInfoRepository? appInfoRepository) =>
            AppInfoRepository(psApiService: psApiService),
  ),
  ProxyProvider3<PsSharedPreferences, PsApiService, LanguageDao,
      LanguageRepository>(
    update: (_,
            PsSharedPreferences ssSharedPreferences,
            PsApiService psApiService,
            LanguageDao languageDao,
            LanguageRepository? languageRepository) =>
        LanguageRepository(
            psSharedPreferences: ssSharedPreferences,
            psApiService: psApiService,
            languageDao: languageDao),
  ),
  ProxyProvider<PsApiService, NotificationRepository>(
    update: (_, PsApiService psApiService,
            NotificationRepository? userRepository) =>
        NotificationRepository(
      psApiService: psApiService,
    ),
  ),
  ProxyProvider<PsApiService, ItemPaidHistoryRepository>(
    update: (_, PsApiService psApiService,
            ItemPaidHistoryRepository? itemPaidHistoryRepository) =>
        ItemPaidHistoryRepository(psApiService: psApiService),
  ),
  ProxyProvider<PsApiService, ClearAllDataRepository>(
    update: (_, PsApiService psApiService,
            ClearAllDataRepository? clearAllDataRepository) =>
        ClearAllDataRepository(),
  ),
  ProxyProvider<PsApiService, DeleteTaskRepository>(
    update: (_, PsApiService psApiService,
            DeleteTaskRepository? deleteTaskRepository) =>
        DeleteTaskRepository(),
  ),
  ProxyProvider2<PsApiService, GetInTouchDao, ContactUsRepository>(
    update: (_, PsApiService psApiService, GetInTouchDao getInTouchDao,
            ContactUsRepository? contactUsRepository) =>
        ContactUsRepository(
            psApiService: psApiService, getInTouchDao: getInTouchDao),
  ),
  ProxyProvider2<PsApiService, ItemLocationTownshipDao,
      ItemLocationTownshipRepository>(
    update: (_,
            PsApiService psApiService,
            ItemLocationTownshipDao itemLocationTownshipDao,
            ItemLocationTownshipRepository? itemLocationTownshipRepository) =>
        ItemLocationTownshipRepository(
            psApiService: psApiService,
            itemLocationTownshipDao: itemLocationTownshipDao),
  ),
  ProxyProvider<PsApiService, TokenRepository>(
    update: (_, PsApiService psApiService, TokenRepository? tokenRepository) =>
        TokenRepository(psApiService: psApiService),
  ),
  ProxyProvider2<PsApiService, UserDao, SearchUserRepository>(
    update: (_, PsApiService psApiService, UserDao userDao,
            SearchUserRepository? categoryRepository2) =>
        SearchUserRepository(psApiService: psApiService, userDao: userDao),
  ),
  ProxyProvider2<PsApiService, UserDao, TopSellerRepository>(
    update: (_, PsApiService psApiService, UserDao userDao,
            TopSellerRepository? categoryRepository2) =>
        TopSellerRepository(psApiService: psApiService, userDao: userDao),
  ),
  ProxyProvider2<PsApiService, UserDao, AgentRepository>(
    update: (_, PsApiService psApiService, UserDao userDao,
            AgentRepository? categoryRepository2) =>
        AgentRepository(psApiService: psApiService, userDao: userDao),
  ),
  ProxyProvider2<PsApiService, PhoneCountryCodeDao, PhoneCountryCodeRepository>(
    update: (_,
            PsApiService psApiService,
            PhoneCountryCodeDao phoneCountryCodeDao,
            PhoneCountryCodeRepository? phoneCountryCodeRepository) =>
        PhoneCountryCodeRepository(
            psApiService: psApiService,
            phoneCountryCodeDao: phoneCountryCodeDao),
  ),
  ProxyProvider2<PsApiService, OfflinePaymentDao,
      OfflinePaymentMethodRepository>(
    update: (_,
            PsApiService psApiService,
            OfflinePaymentDao offlinePaymentMethodDao,
            OfflinePaymentMethodRepository? categoryRepository2) =>
        OfflinePaymentMethodRepository(
            psApiService: psApiService,
            offlinePaymentMethodDao: offlinePaymentMethodDao),
  ),
  
 
  ProxyProvider2<PsApiService, ProductDao, ProductRepository>(
    update: (_, PsApiService psApiService, ProductDao productDao,
            ProductRepository? categoryRepository2) =>
        ProductRepository(psApiService: psApiService, productDao: productDao),
  ),
  ProxyProvider2<PsApiService, NotiDao, NotiRepository>(
    update: (_, PsApiService psApiService, NotiDao notiDao,
            NotiRepository? notiRepository) =>
        NotiRepository(psApiService: psApiService, notiDao: notiDao),
  ),
 
  
  ProxyProvider2<PsApiService, PackageDao, PackageBoughtRepository>(
    update: (_, PsApiService psApiService, PackageDao packageDao,
            PackageBoughtRepository? packageRepository) =>
        PackageBoughtRepository(
            psApiService: psApiService, packageDao: packageDao),
  ),
  ProxyProvider2<PsApiService, PackageTransactionDao,
      PackageTranscationHistoryRepository>(
    update: (_, PsApiService psApiService, PackageTransactionDao packageDao,
            PackageTranscationHistoryRepository? packageRepository) =>
        PackageTranscationHistoryRepository(
            psApiService: psApiService, transactionDao: packageDao),
  ),
  ProxyProvider2<PsApiService, PromotionTransactionDao,
      PromotionTranscationRepository>(
    update: (_,
            PsApiService psApiService,
            PromotionTransactionDao promotransactionDao,
            PromotionTranscationRepository? packageRepository) =>
        PromotionTranscationRepository(
            psApiService: psApiService,
            promotransactionDao: promotransactionDao),
  ),
 

  ProxyProvider2<PsApiService, ItemLocationDao, ItemLocationRepository>(
    update: (_, PsApiService psApiService, ItemLocationDao itemLocationDao,
            ItemLocationRepository? itemLocationRepository) =>
        ItemLocationRepository(
            psApiService: psApiService, itemLocationDao: itemLocationDao),
  ),
  
  ProxyProvider2<PsApiService, ItemCurrencyDao, ItemCurrencyRepository>(
    update: (_, PsApiService psApiService, ItemCurrencyDao itemCurrencyDao,
            ItemCurrencyRepository? itemCurrencyRepository) =>
        ItemCurrencyRepository(
            psApiService: psApiService, itemCurrencyDao: itemCurrencyDao),
  ),
  ProxyProvider2<PsApiService, ChatHistoryDao, ChatHistoryRepository>(
    update: (_, PsApiService psApiService, ChatHistoryDao chatHistoryDao,
            ChatHistoryRepository? chatHistoryRepository) =>
        ChatHistoryRepository(
            psApiService: psApiService, chatHistoryDao: chatHistoryDao),
  ),
  ProxyProvider2<PsApiService, OfferDao, OfferRepository>(
    update: (_, PsApiService psApiService, OfferDao offerDao,
            OfferRepository? offerRepository) =>
        OfferRepository(psApiService: psApiService, offerDao: offerDao),
  ),
  ProxyProvider2<PsApiService, UserUnreadMessageDao,
      UserUnreadMessageRepository>(
    update: (_,
            PsApiService psApiService,
            UserUnreadMessageDao userUnreadMessageDao,
            UserUnreadMessageRepository? userUnreadMessageRepository) =>
        UserUnreadMessageRepository(
            psApiService: psApiService,
            userUnreadMessageDao: userUnreadMessageDao),
  ),
  ProxyProvider2<PsApiService, RatingDao, RatingRepository>(
    update: (_, PsApiService psApiService, RatingDao ratingDao,
            RatingRepository? ratingRepository) =>
        RatingRepository(psApiService: psApiService, ratingDao: ratingDao),
  ),
  ProxyProvider2<PsApiService, PaidAdItemDao, PaidAdItemRepository>(
    update: (_, PsApiService psApiService, PaidAdItemDao paidAdItemDao,
            PaidAdItemRepository? paidAdItemRepository) =>
        PaidAdItemRepository(
            psApiService: psApiService, paidAdItemDao: paidAdItemDao),
  ),
  ProxyProvider2<PsApiService, HistoryDao, HistoryRepository>(
    update: (_, PsApiService psApiService, HistoryDao historyDao,
            HistoryRepository? historyRepository) =>
        HistoryRepository(historyDao: historyDao),
  ),
  ProxyProvider2<PsApiService, GalleryDao, GalleryRepository>(
    update: (_, PsApiService psApiService, GalleryDao galleryDao,
            GalleryRepository? galleryRepository) =>
        GalleryRepository(galleryDao: galleryDao, psApiService: psApiService),
  ),
  ProxyProvider3<PsApiService, UserDao, UserLoginDao, UserRepository>(
    update: (_, PsApiService psApiService, UserDao userDao,
            UserLoginDao userLoginDao, UserRepository? userRepository) =>
        UserRepository(
            psApiService: psApiService,
            userDao: userDao,
            userLoginDao: userLoginDao),
  ),
  ProxyProvider2<PsApiService, AllSearchResultDao, AllSearchResultRepository>(
    update: (_, PsApiService psApiService, AllSearchResultDao searchResultDao,
            AllSearchResultRepository? galleryRepository) =>
        AllSearchResultRepository(
            searchResultDao: searchResultDao, apiService: psApiService),
  ),
  ProxyProvider2<PsApiService, MobileColorDao, MobileColorRepository>(
    update: (_, PsApiService psApiService, MobileColorDao mobileColorDao,
            MobileColorRepository? bestChoiceRepository) =>
        MobileColorRepository(
            psApiService: psApiService, mobileColorDao: mobileColorDao),
  ),
  ProxyProvider2<PsApiService, SearchCategoryHistoryDao,
      SearchCategoryHistoryRepository>(
    update: (_,
            PsApiService psApiService,
            SearchCategoryHistoryDao searchCategoryHistoryDao,
            SearchCategoryHistoryRepository? searchCategoryHistoryRepository) =>
        SearchCategoryHistoryRepository(
            psApiService: psApiService,
            searchCategoryHistoryDao: searchCategoryHistoryDao),
  ),
  ProxyProvider2<PsApiService, SearchSubCategoryHistoryDao,
      SearchSubCategoryHistoryRepository>(
    update: (_,
            PsApiService psApiService,
            SearchSubCategoryHistoryDao searchSubCategoryHistoryDao,
            SearchSubCategoryHistoryRepository?
                searchSubCategoryHistoryRepository) =>
        SearchSubCategoryHistoryRepository(
            psApiService: psApiService,
            searchSubCategoryHistoryDao: searchSubCategoryHistoryDao),
  ),
  ProxyProvider2<PsApiService, SearchItemHistoryDao,
      SearchItemHistoryRepository>(
    update: (_,
            PsApiService psApiService,
            SearchItemHistoryDao searchItemHistoryDao,
            SearchItemHistoryRepository? searchItemHistoryRepository) =>
        SearchItemHistoryRepository(
            psApiService: psApiService,
            searchItemHistoryDao: searchItemHistoryDao),
  ),

  //ecommerce
  ProxyProvider2<PsApiService, BestChoiceDao, BestChoiceRepository>(
    update: (_, PsApiService psApiService, BestChoiceDao bestChoiceDao,
            BestChoiceRepository? bestChoiceRepository) =>
        BestChoiceRepository(
            psApiService: psApiService, bestChoiceDao: bestChoiceDao),
  ),
  ProxyProvider2<PsApiService, ProductDao, ProductByCollectionIdRepository>(
    update: (_, PsApiService psApiService, ProductDao productDao,
            ProductByCollectionIdRepository? productByCollectionIdRepository) =>
        ProductByCollectionIdRepository(
            psApiService: psApiService, productDao: productDao),
  ),
  ProxyProvider2<PsApiService, ProductCollectionDao,
      ProductCollectionRepository>(
    update: (_,
            PsApiService psApiService,
            ProductCollectionDao productCollectionDao,
            ProductCollectionRepository? productCollectionRepository) =>
        ProductCollectionRepository(
            psApiService: psApiService,
            productCollectionDao: productCollectionDao),
  ),
  ProxyProvider2<PsApiService, ScheduleDetailDao, ScheduleDetailRepository>(
    update: (_, PsApiService psApiService, ScheduleDetailDao scheduleDetailDao,
            ScheduleDetailRepository? scheduleDetailRepository) =>
        ScheduleDetailRepository(
            apiService: psApiService, scheduleDetailDao: scheduleDetailDao),
  ),
  ProxyProvider2<PsApiService, ScheduleHeaderDao, ScheduleHeaderRepository>(
    update: (_, PsApiService psApiService, ScheduleHeaderDao scheduleHeaderDao,
            ScheduleHeaderRepository? scheduleHeaderRepository) =>
        ScheduleHeaderRepository(
            apiService: psApiService, scheduleHeaderDao: scheduleHeaderDao),
  ),
  ProxyProvider2<PsApiService, SearchHistoryDao, SearchHistoryRepository>(
    update: (_, PsApiService psApiService, SearchHistoryDao searchHistoryDao,
            SearchHistoryRepository? scheduleHeaderRepository) =>
        SearchHistoryRepository(
            psApiService: psApiService, searchHistoryDao: searchHistoryDao),
  ),
  ProxyProvider2<PsApiService, SearchResultDao, SearchResultRepository>(
    update: (_, PsApiService psApiService, SearchResultDao searchResultDao,
            SearchResultRepository? searchResultRepository) =>
        SearchResultRepository(
            apiService: psApiService, searchResultDao: searchResultDao),
  ),
  ProxyProvider2<PsApiService, ShippingAreaDao, ShippingAreaRepository>(
    update: (_, PsApiService psApiService, ShippingAreaDao shippingAreaDao,
            ShippingAreaRepository? shippingAreaRepository) =>
        ShippingAreaRepository(
            psApiService: psApiService, shippingAreaDao: shippingAreaDao),
  ),
  ProxyProvider2<PsApiService, ShopInfoDao, ShopInfoRepository>(
    update: (_, PsApiService psApiService, ShopInfoDao shopInfoDao,
            ShopInfoRepository? shopInfoRepository) =>
        ShopInfoRepository(
            psApiService: psApiService, shopInfoDao: shopInfoDao),
  ),
  ProxyProvider2<PsApiService, ShopRatingDao, ShopRatingRepository>(
    update: (_, PsApiService psApiService, ShopRatingDao shopRatingDao,
            ShopRatingRepository? shopRatingRepository) =>
        ShopRatingRepository(
            psApiService: psApiService, shopRatingDao: shopRatingDao),
  ),
  ProxyProvider2<PsApiService, ShopDao, ShopRepository>(
    update: (_, PsApiService psApiService, ShopDao shopDao,
            ShopRepository? shopRatingRepository) =>
        ShopRepository(psApiService: psApiService, dao: shopDao),
  ),
  ProxyProvider2<PsApiService, TransactionDetailDao,
      TransactionDetailRepository>(
    update: (_,
            PsApiService psApiService,
            TransactionDetailDao transactionDetailDao,
            TransactionDetailRepository? transactionDetailRepository) =>
        TransactionDetailRepository(
            psApiService: psApiService,
            transactionDetailDao: transactionDetailDao),
  ),
  ProxyProvider2<PsApiService, TransactionHeaderDao,
      TransactionHeaderRepository>(
    update: (_,
            PsApiService psApiService,
            TransactionHeaderDao transactionHeaderDao,
            TransactionHeaderRepository? transactionHeaderRepository) =>
        TransactionHeaderRepository(
            psApiService: psApiService,
            transactionHeaderDao: transactionHeaderDao),
  ),
  ProxyProvider2<PsApiService, TransactionStatusDao,
      TransactionStatusRepository>(
    update: (_,
            PsApiService psApiService,
            TransactionStatusDao transactionStatusDao,
            TransactionStatusRepository? transactionStatusRepository) =>
        TransactionStatusRepository(
            psApiService: psApiService,
            transactionStatusDao: transactionStatusDao),
  ),
  ProxyProvider2<PsApiService, VendorUserDao, VendorUserRepository>(
    update: (_, PsApiService psApiService, VendorUserDao vendorUserDao,
            VendorUserRepository? vendorUserRepository) =>
        VendorUserRepository(
            psApiService: psApiService, vendorUserDao: vendorUserDao),
  ),

  ProxyProvider2<PsApiService, VendorBranchDao, VendorBranchRepository>(
    update: (_, PsApiService psApiService, VendorBranchDao branchDao,
            VendorBranchRepository? vendorBranchRepository) =>
        VendorBranchRepository(
            psApiService: psApiService, branchDao: branchDao),
  ),
 
  ProxyProvider2<PsApiService, OrderIdDao, OrderIdRepository>(
    update: (_, PsApiService psApiService, OrderIdDao orderIdDao,
            OrderIdRepository? orderIdRepository) =>
        OrderIdRepository(psApiService: psApiService, orderIdDao: orderIdDao),
  ),
  ProxyProvider2<PsApiService, VendorUserDao, VendorSearchRepository>(
    update: (_, PsApiService psApiService, VendorUserDao vendorUserDao,
            VendorSearchRepository? vendorSearchRepository) =>
        VendorSearchRepository(
            psApiService: psApiService, vendorUserDao: vendorUserDao),
  ),
  ProxyProvider<PsApiService, VendorPaypalTokenRepository>(
    update: (_, PsApiService psApiService,
            VendorPaypalTokenRepository? vendorPaypalTokenRepository) =>
        VendorPaypalTokenRepository(psApiService: psApiService),
  ),
  ProxyProvider<PsApiService, VendorItemBoughtRepository>(
    update: (_, PsApiService psApiService,
            VendorItemBoughtRepository? vendorItemBoughtRepository) =>
        VendorItemBoughtRepository(psApiService: psApiService),
  ),
  ProxyProvider<PsApiService, AddNewBillingAddressRepository>(
    update: (_,
            PsApiService psApiService,
            AddNewBillingAddressRepository?
                addNewBillingAddressReAddNewBillingAddressRepository) =>
        AddNewBillingAddressRepository(
      psApiService: psApiService,
    ),
  ),
  ProxyProvider<PsApiService, AddNewShippingAddressRepository>(
    update: (_,
            PsApiService psApiService,
            AddNewShippingAddressRepository?
                addNewBillingAddressReAddNewShippingAddressRepository) =>
        AddNewShippingAddressRepository(
      psApiService: psApiService,
    ),
  ),
  ProxyProvider<PsApiService, EditShippingAddressRepository>(
    update: (_, PsApiService psApiService,
            EditShippingAddressRepository? editShippingAddressRepository) =>
        EditShippingAddressRepository(
      psApiService: psApiService,
    ),
  ),
    ProxyProvider<PsApiService, EditBillingAddressRepository>(
    update: (_, PsApiService psApiService,
            EditBillingAddressRepository? editBillingAddressRepository) =>
        EditBillingAddressRepository(
      psApiService: psApiService,
    ),
  ),
  ProxyProvider2<PsApiService, VendorInfoDao, VendorInfoRepository>(
    update: (_, PsApiService psApiService, VendorInfoDao vendorInfoDao,
            VendorInfoRepository? vendorInfoRepository) =>
        VendorInfoRepository(
            psApiService: psApiService, vendorInfoDao: vendorInfoDao),
  ),
  ProxyProvider2<PsApiService, AddToCartDao, AddToCartRepository>(
    update: (_, PsApiService psApiService, AddToCartDao addToCartDao,
            AddToCartRepository? addToCartRepository) =>
        AddToCartRepository(
            psApiService: psApiService, addToCartDao: addToCartDao),
  )
];

List<SingleChildWidget> _valueProviders = <SingleChildWidget>[
  StreamProvider<PsValueHolder?>(
    initialData: null,
    create: (BuildContext context) =>
        Provider.of<PsSharedPreferences>(context, listen: false).psValueHolder,
  )
];
