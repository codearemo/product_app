// To parse this JSON data, do
//
//     final generalResponseModel = generalResponseModelFromJson(jsonString);

import 'dart:convert';

GeneralResponseModel generalResponseModelFromJson(String str) => GeneralResponseModel.fromJson(json.decode(str));

String generalResponseModelToJson(GeneralResponseModel data) => json.encode(data.toJson());

class GeneralResponseModel<T> {
    final String? message;
    final T? data;
    final Meta? meta;

    GeneralResponseModel({
        this.message,
        this.data,
        this.meta,
    });

    GeneralResponseModel copyWith({
        String? message,
        T? data,
        Meta? meta,
    }) => 
        GeneralResponseModel(
            message: message ?? this.message,
            data: data ?? this.data,
            meta: meta ?? this.meta,
        );

    factory GeneralResponseModel.fromJson(Map<String, dynamic> json) => GeneralResponseModel(
        message: json["message"],
        data: json["data"],
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data,
        "meta": meta?.toJson(),
    };
}

class Meta {
    final int? total;
    final int? perPage;
    final int? pageCount;
    final int? page;
    final int? pagingCounter;
    final bool? hasPrevPage;
    final bool? hasNextPage;
    final int? prevPage;
    final int? nextPage;

    Meta({
        this.total,
        this.perPage,
        this.pageCount,
        this.page,
        this.pagingCounter,
        this.hasPrevPage,
        this.hasNextPage,
        this.prevPage,
        this.nextPage,
    });

    Meta copyWith({
        int? total,
        int? perPage,
        int? pageCount,
        int? page,
        int? pagingCounter,
        bool? hasPrevPage,
        bool? hasNextPage,
        int? prevPage,
        int? nextPage,
    }) => 
        Meta(
            total: total ?? this.total,
            perPage: perPage ?? this.perPage,
            pageCount: pageCount ?? this.pageCount,
            page: page ?? this.page,
            pagingCounter: pagingCounter ?? this.pagingCounter,
            hasPrevPage: hasPrevPage ?? this.hasPrevPage,
            hasNextPage: hasNextPage ?? this.hasNextPage,
            prevPage: prevPage ?? this.prevPage,
            nextPage: nextPage ?? this.nextPage,
        );

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        total: json["total"],
        perPage: json["perPage"],
        pageCount: json["pageCount"],
        page: json["page"],
        pagingCounter: json["pagingCounter"],
        hasPrevPage: json["hasPrevPage"],
        hasNextPage: json["hasNextPage"],
        prevPage: json["prevPage"],
        nextPage: json["nextPage"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "perPage": perPage,
        "pageCount": pageCount,
        "page": page,
        "pagingCounter": pagingCounter,
        "hasPrevPage": hasPrevPage,
        "hasNextPage": hasNextPage,
        "prevPage": prevPage,
        "nextPage": nextPage,
    };
}
