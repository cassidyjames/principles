project ('com.github.cassidyjames.principles', 'vala', 'c')

gnome = import ('gnome')

add_global_arguments ('-DGETTEXT_PACKAGE="' + meson.project_name () + '"', language:'c')

executable(
    meson.project_name (),
    'src/Application.vala',
    'src/Content.vala',
    'src/MainWindow.vala',
    dependencies: [
        dependency ('glib-2.0'),
        dependency ('gtk+-3.0')
    ],
    install: true
)

subdir ('data')

