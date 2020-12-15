package com.flutter.facebookapp

import com.google.gson.Gson
import com.google.gson.JsonObject
import com.google.gson.reflect.TypeToken
import java.lang.reflect.Type
import java.util.*


/**
 * Time: 2019/5/29
 * Author:wyy
 * Description:
 */
class GsonUtil private constructor() {


    init {
        /* cannot be instantiated */
        throw UnsupportedOperationException("cannot be instantiated")

    }

    companion object {

        private var gson: Gson? = null

        fun gson(): Gson {
            if (gson == null) {
                synchronized(Gson::class.java) {
                    if (gson == null) {
                        gson = Gson()
                    }
                }
            }
            return gson!!
        }

        /**
         *
         * @param json
         *
         * @param clazz
         *
         * @return
         */
        fun <T> jsonToArrayList(json: String?, clazz: Class<T>?): ArrayList<T>? {
            val type: Type = object : TypeToken<ArrayList<JsonObject?>?>() {}.type
            val jsonObjects: ArrayList<JsonObject> = Gson().fromJson(json, type)
            val arrayList: ArrayList<T> = ArrayList()
            for (jsonObject in jsonObjects) {
                arrayList.add(Gson().fromJson(jsonObject, clazz))
            }
            return arrayList
        }
    }




}

