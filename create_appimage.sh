#!/bin/bash -x
export X_SOURCE_PATH=$PWD
export X_RELEASE_VERSION=$(cat "release_version.txt")
export VERSION=$X_RELEASE_VERSION

source build_tools/linux.sh

create_image_app_dir xocalc

cp -f $X_SOURCE_PATH/build/release/xocalc                           $X_SOURCE_PATH/release/appDir/usr/bin/
cp -f $X_SOURCE_PATH/LINUX/xocalc.desktop                           $X_SOURCE_PATH/release/appDir/usr/share/applications/
sed -i "s/#VERSION#/1.0/"                                           $X_SOURCE_PATH/release/appDir/usr/share/applications/xocalc.desktop
cp -Rf $X_SOURCE_PATH/LINUX/hicolor/                                $X_SOURCE_PATH/release/appDir/usr/share/icons/
cp -Rf $X_SOURCE_PATH/images/                                       $X_SOURCE_PATH/release/appDir/usr/lib/xocalc/

cd $X_SOURCE_PATH/release

linuxdeployqt $X_SOURCE_PATH/release/appDir/usr/share/applications/xocalc.desktop -appimage -always-overwrite
#mv *.AppImage xapkd_${X_RELEASE_VERSION}.AppImage

cd $X_SOURCE_PATH

rm -Rf $X_SOURCE_PATH/release/appDir
