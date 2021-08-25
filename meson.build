project(
    'com.github.cassidyjames.principles',
    'vala', 'c',
    version: '2.0.1'
)

gnome = import('gnome')
i18n = import('i18n')

add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()), language:'c')

asresources = gnome.compile_resources(
    'as-resources', 'data/gresource.xml',
    source_dir: 'data',
    c_name: 'as'
)

executable(
    meson.project_name(),
    asresources,
    'src' / 'Application.vala',
    'src' / 'Content.vala',
    'src' / 'MainWindow.vala',
    dependencies: [
        dependency('glib-2.0', version: '>=2.64'),
        dependency('granite', version: '>=6.1'),
        dependency('gtk+-3.0', version: '>=3.24'),
        dependency('libhandy-1', version: '>= 1.0'),
    ],
    install: true
)

subdir('data')
subdir('po')

meson.add_install_script('meson/post_install.py')
