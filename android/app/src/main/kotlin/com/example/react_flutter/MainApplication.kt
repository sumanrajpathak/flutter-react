package com.example.react_flutter

import android.app.Application
import com.facebook.react.BuildConfig
import com.facebook.react.PackageList
import com.facebook.react.ReactApplication
import com.facebook.react.ReactNativeHost
import com.facebook.react.ReactPackage
import com.facebook.soloader.SoLoader

open class MainApplication : Application(), ReactApplication {
    override fun onCreate() {
        super.onCreate()
        SoLoader.init(this, false)
    }

    private val mReactNativeHost: ReactNativeHost = object : ReactNativeHost(this) {

        override fun getJSMainModuleName(): String {
            return "index"
        }
        override fun getUseDeveloperSupport(): Boolean {
            return BuildConfig.DEBUG
        }

        override fun getPackages(): MutableList<ReactPackage> {
            return PackageList(this).getPackages()
        }
    }

    override fun getReactNativeHost(): ReactNativeHost {
        return mReactNativeHost
    }
}