#! e:/program files/perl/bin/perl.exe
#  version info can be found in 'configure.ac'

require "../local-paths.lib";

$gtk_version = "2.24.22";
$major = 2;
$minor = 24;
$micro = 22;
$interface_age = 22;
$binary_age = 2422;
$current_minus_age = 0;
$gettext_package = "gtk20";
$gtk_icon_dir = "../rc";
$gtk_binary_version = "v2.24"; # Used to locate various modules and '.rc' files. Change this only when absolutely necessary !
$exec_prefix = "lib";

sub process_file
{
        my $outfilename = shift;
	my $infilename = $outfilename . ".in";
	
	open (INPUT, "< $infilename") || exit 1;
	open (OUTPUT, "> $outfilename") || exit 1;
	
	while (<INPUT>) {
	    s/\@ATK_API_VERSION@/$atk_api_version/g;
	    s/\@PANGO_API_VERSION@/$pango_api_version/g;
	    s/\@GLIB_API_VERSION@/$glib_api_version/g;
	    s/\@GTK_API_VERSION@/$gtk_api_version/g;
	    s/\@GDK_PIXBUF_API_VERSION@/$gdk_pixbuf_api_version/g;
	    s/\@GTK_VERSION@/$gtk_version/g;
	    s/\@GTK_MAJOR_VERSION\@/$major/g;
	    s/\@GTK_MINOR_VERSION\@/$minor/g;
	    s/\@GTK_MICRO_VERSION\@/$micro/g;
	    s/\@GTK_BINARY_VERSION\@/$gtk_binary_version/g;
	    s/\@GTK_BINARY_AGE\@/$binary_age/g;
	    s/\@GTK_INTERFACE_AGE\@/$interface_age/g;
	    s/\@LT_CURRENT_MINUS_AGE@/$current_minus_age/g;
	    s/\@GETTEXT_PACKAGE\@/$gettext_package/g;
	    s/\@PERL@/$perl_path/g;
	    s/\@GlibBuildRootFolder@/$glib_build_root_folder/g;
	    s/\@GtkBuildRootFolder@/$gtk_build_root_folder/g;
	    s/\@GdkPixbufBuildRootFolder@/$gdk_pixbuf_build_root_folder/g;
	    s/\@GtkBuildProjectFolder@/$gtk_build_project_folder/g;
	    s/\@GenericIncludeFolder@/$generic_include_folder/g;
	    s/\@GenericLibraryFolder@/$generic_library_folder/g;
	    s/\@GenericWin32LibraryFolder@/$generic_win32_library_folder/g;
	    s/\@GenericWin32BinaryFolder@/$generic_win32_binary_folder/g;
	    s/\@Debug32TestSuiteFolder@/$debug32_testsuite_folder/g;
	    s/\@Release32TestSuiteFolder@/$release32_testsuite_folder/g;
	    s/\@Debug32TargetFolder@/$debug32_target_folder/g;
	    s/\@Release32TargetFolder@/$release32_target_folder/g;
	    s/\@TargetSxSFolder@/$target_sxs_folder/g;
	    s/\@prefix@/$prefix/g;
	    s/\@exec_prefix@/$exec_prefix/g;
	    s/\@includedir@/$generic_include_folder/g;
	    s/\@libdir@/$generic_library_folder/g;
	    s/\@srcdir@/$gtk_icon_dir/g;
	    s/\@gdktarget@/$target/g;
	    s/\@VERSION@/$gtk_version/g;
	    print OUTPUT;
	}
}

my $command=join(' ',@ARGV);

if (-1 != index($command, "-X64")) {
	$target = "64";
} else {
	$target = "32";
}

process_file ("config.h.win32");
process_file ("gtk/gtkversion.h");
process_file ("demos/gtk-demo/geninclude.pl");
process_file ("gail.pc");
process_file ("gdk-2.0.pc");
process_file ("gtk+-2.0.pc");

if (-1 != index($command, "-buildall")) {
	process_file ("msvc/gtk.vsprops");
	process_file ("gdk/win32/rc/gdk.rc");
	process_file ("gtk/gtk-win32.rc");
}