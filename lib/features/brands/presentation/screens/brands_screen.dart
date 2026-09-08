import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/extension/utility_extension.dart';
import '../../../shared/presentation/widget/centered_progress_indicator.dart';
import '../../../shared/presentation/widget/no_image.dart';
import '../providers/brand_provider.dart';

class BrandsScreen extends StatefulWidget {
  const BrandsScreen({super.key});

  static const String name = '/brands';

  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  final BrandProvider _brandProvider = BrandProvider();

  @override
  void initState() {
    super.initState();
    _brandProvider.fetchBrands();
  }

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider.value(
      value: _brandProvider,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.localization.brands),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: Consumer<BrandProvider>(
                  builder: (context, _, _) {
                    if (_brandProvider.isLoading) {
                      return CenteredProgressIndicator();
                    }
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.white,
                          elevation: 3,
                          shadowColor: AppColors.themeColor,
                          child: ListTile(
                            leading: CachedNetworkImage(
                              imageUrl: _brandProvider.brands[index].icon,
                              errorWidget: (context, _, _) {
                                return NoImage();
                              },
                            ),
                            title: Text(_brandProvider.brands[index].title, style: TextStyle(color: Colors.black),),
                            subtitle: Text(
                              _brandProvider.brands[index].description,style: TextStyle(color: Colors.black)
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 8);
                      },
                      itemCount: _brandProvider.brands.length,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
