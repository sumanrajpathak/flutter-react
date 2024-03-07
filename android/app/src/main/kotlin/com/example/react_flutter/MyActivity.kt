package com.example.react_flutter

import android.os.Bundle
import android.view.KeyEvent
import com.facebook.hermes.reactexecutor.HermesExecutorFactory
import com.facebook.react.BuildConfig
import com.facebook.react.PackageList

import com.facebook.react.ReactActivity

import com.facebook.react.ReactInstanceManager

import com.facebook.react.ReactPackage

import com.facebook.react.ReactRootView

import com.facebook.react.common.LifecycleState

import com.facebook.react.modules.core.DefaultHardwareBackBtnHandler

import com.facebook.soloader.SoLoader


open class MyActivity : ReactActivity(), DefaultHardwareBackBtnHandler {
    private var mReactRootView: ReactRootView? = null
    private var mReactInstanceManager: ReactInstanceManager? = null
    protected override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        SoLoader.init(this, false)
        mReactRootView = ReactRootView(this)
        val packages: List<ReactPackage> = PackageList(application).packages
        mReactInstanceManager = ReactInstanceManager.builder()
            .setJavaScriptExecutorFactory(HermesExecutorFactory())
            .setApplication(application)
            .setCurrentActivity(this)
            .setBundleAssetName("index.android.bundle")
            .setJSMainModulePath("index")
            .addPackages(packages)
            .setUseDeveloperSupport(BuildConfig.DEBUG)
            .setInitialLifecycleState(LifecycleState.RESUMED)
            .build()

        // The string here (e.g. "reactapp") has to match
        // the string in AppRegistry.registerComponent() in index.js
        val initialProperties = Bundle()
        mReactRootView!!.startReactApplication(mReactInstanceManager, "reactapp", initialProperties)
        setContentView(mReactRootView)
    }

    override fun invokeDefaultOnBackPressed() {
        super.onBackPressed()
    }

    protected override fun onPause() {
        super.onPause()
        mReactInstanceManager?.onHostPause(this)
    }

    protected override fun onResume() {
        super.onResume()
        mReactInstanceManager?.onHostResume(this, this)
    }

    protected override fun onDestroy() {
        super.onDestroy()
        mReactInstanceManager?.onHostDestroy(this)
        mReactRootView?.unmountReactApplication()
    }

    override fun onBackPressed() {
        if (mReactInstanceManager != null) {
            mReactInstanceManager!!.onBackPressed()
        } else {
            super.onBackPressed()
        }
    }

    override fun onKeyUp(keyCode: Int, event: KeyEvent?): Boolean {
        if (keyCode == KeyEvent.KEYCODE_MENU && mReactInstanceManager != null) {
            mReactInstanceManager!!.showDevOptionsDialog()
            return true
        }
        return super.onKeyUp(keyCode, event)
    }
}