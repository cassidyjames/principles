project (
    'com.github.cassidyjames.principles',
    'vala', 'c',
    version: '1.2.3'
)

gnome = import ('gnome')
i18n = import('i18n')

add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()), language:'c')

asresources = gnome.compile_resources(
    'as-resources', 'data/gresource.xml',
    source_dir: 'data',
    c_name: 'as'
)

executable(
    meson.project_name (),
    asresources,
    'src/Application.vala',
    'src/Content.vala',
    'src/MainWindow.vala',
    dependencies: [
        dependency ('glib-2.0'),
        dependency ('granite'),
        dependency ('gtk+-3.0'),
    ],
    install: true
)

subdir ('data')
subdir ('po')

meson.add_install_script('meson/post_install.py')
