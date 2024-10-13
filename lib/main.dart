import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong/core/core.dart';
import 'package:klontong/core/network/app_api.dart';
import 'package:klontong/core/network/network.dart';
import 'package:klontong/data/data.dart';
import 'package:klontong/presentation/presentation.dart';
import 'package:klontong/presentation/shared/navigation/args/args.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://0c10bc5a68ba1aaa7564a1af8c081e16@o4508115168919552.ingest.us.sentry.io/4508115170361344';
      options.tracesSampleRate = 1.0;
      options.profilesSampleRate = 1.0;
    },
    appRunner: () => runApp(const MyApp()),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      useInheritedMediaQuery: true,
      minTextAdapt: true,
      builder: (context, child) => child!,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: appTheme,
        // home: const ProductListScreen(),
        initialRoute: AppRouter.productList,
        onGenerateRoute: (settings) {
          final arguments = settings.arguments;
          switch (settings.name) {
            case AppRouter.productList:
              return MaterialPageRoute(
                builder: (context) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => ProductListCubit(
                          remoteDatasource: RemoteDataSourceImpl(
                            dioHandler: DioHandler(
                              apiBaseUrl: AppApi.baseUrl,
                            ),
                          ),
                          debouncer: Debouncer(milliseconds: 400),
                        )..fetchProducts(),
                      )
                    ],
                    child: const ProductListScreen(),
                  );
                },
              );
            case AppRouter.productDetail:
              return MaterialPageRoute(
                builder: (context) {
                  return MultiBlocProvider(providers: [
                    BlocProvider(
                      create: (context) => ProductDetailCubit(
                        id: arguments as String,
                        remoteDatasource: RemoteDataSourceImpl(
                          dioHandler: DioHandler(apiBaseUrl: AppApi.baseUrl),
                        ),
                      )..fetchDetailProduct(),
                    )
                  ], child: const ProductDetailScreen());
                },
              );
            case AppRouter.createProduct:
              CreateArgs args = arguments as CreateArgs;
              return MaterialPageRoute(
                builder: (context) {
                  return MultiBlocProvider(providers: [
                    BlocProvider(
                      create: (context) => CreateProductCubit(
                        remoteDatasource: RemoteDataSourceImpl(
                          dioHandler: DioHandler(
                            apiBaseUrl: AppApi.baseUrl,
                          ),
                        ),
                        isEdit: args.isEdit,
                        product: args.product,
                      ),
                    )
                  ], child: const CreateProductScreen());
                },
              );

            default:
              return null;
          }
        },
      ),
    );
  }
}
