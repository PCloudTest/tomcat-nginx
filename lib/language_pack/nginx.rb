require "yaml"
require "fileutils"

# TODO logging
module LanguagePack
  class Nginx
    include LanguagePack::PackageFetcher

   
    NGINX_PACKAGE = "https://d35wldypfbhn1h.cloudfront.net/nginx-1.4.1.tar.gz".freeze


    def self.use?
      File.exists?("index.html") || File.exists?("index.htm") || File.exists?("Default.htm") 
    end

    def name
      "Nginx"
    end

    def compile
      Dir.chdir(build_path) do
       
        # install_java
        # install_tomcat
        
        # remove_tomcat_files
        # copy_webapp_to_tomcat
        # delete_app_copy
        # move_tomcat_to_root
        # install_database_drivers
        # install_database_drivers_for_tn
        #install_insight
        
        # copy_resources
        # setup_profiled
        move_nginx
        move_configure_to_root
        
        
        
      end
    end


    # def install_nginx
    #   puts "Downloading nginx-1.4.1---#{build_path}--2---#{homepath}-------"
    #   # FileUtils.mkdir_p nginx_dir
    #   run_with_err_output("curl -s --max-time 60 ${NGINX_PACKAGE} |tar xz")

    # end
    # def configure_nginx
    #   puts "configure_nginx"
    #   run_with_err_output("cp -f #{File.expand_path('../../../resources/nginx/nginx.conf', __FILE__)} nginx/conf/nginx.conf && "+
    #     "cp -f #{File.expand_path('../../../resources/nginx/mime.types', __FILE__)} nginx/conf/mime.types")
    # end


    # def app_dir
    #   ".appss"
    # end

    # def move_app_to_dir
    #   puts "move app to dir....."
    #   FileUtils.mkdir_p app_dir
    #   run_with_err_output("cp -fr * #{app_dir}/")
    #   # run_with_err_output("mv -f * #{app_dir}/")
    # end


    def move_nginx
      puts "install nginx package....."

      run_with_err_output("cp -r #{File.expand_path('../../../resources/nginx', __FILE__)} .")
      run_with_err_output("cp -r #{File.expand_path('../../../resources/nginxconf/nginx.conf', __FILE__)} #{build_path}/nginx/conf/")
      run_with_err_output("mv nginx .nginx")
    end

    

    def copy_webapp_to_tomcat
      puts"copy_webapp_to_tomcat"
       
       # run_with_err_output("mkdir -p #{tomcat_dir}/webapps/ROOT && mv * #{tomcat_dir}/webapps/ROOT")
       # run_with_err_output("rm -fr #{tomcat_dir}/webapps/ROOT/index.jsp")
      # run_with_err_output("cp -f *.html #{tomcat_dir}/webapps/ROOT && rm -fr #{tomcat_dir}/webapps/ROOT/index.jsp  && " +
      #   "mv css js images #{tomcat_dir}/webapps/ROOT/ && mv WEB-INF/web.xml #{tomcat_dir}/webapps/ROOT/WEB-INF")
    # run_with_err_output("mv * #{tomcat_dir}/webapps/ROOT")
    # run_with_err_output("cp -f *.html #{tomcat_dir}/webapps/ROOT  && " +
    #     "mv css js images WEB-INF #{tomcat_dir}/webapps/ROOT/")
      run_with_err_output("rm -fr #{tomcat_dir}/webapps/ROOT/* && cp -fr * #{tomcat_dir}/webapps/ROOT")
      # run_with_err_output("cp -fr * #{tomcat_dir}/webapps/ROOT ")
      # run_with_err_output("mv * #{tomcat_dir}/webapps/ROOT ")
    end

    def move_tomcat_to_root
      run_with_err_output("mv #{tomcat_dir}/* . && rm -rf #{tomcat_dir}")
    end

    def copy_resources
      # Configure server.xml with variable HTTP port
      run_with_err_output("cp -r #{File.expand_path('../../../resources/tomcat', __FILE__)}/* #{build_path}/.tomcat")
    end

   

    def move_configure_to_root
      puts "move boot to root"
      run_with_err_output("cp -r #{File.expand_path('../../../bin/boot.sh', __FILE__)} .")
    end

    def delete_app_copy
      puts "delete app copy"
      run_with_err_output("rm -fr #{build_path}/*")
    end
    
    def release
      {
          "addons" => [],
          "config_vars" => {},
          "default_process_types" => default_process_types
      }.to_yaml
    end

    def default_process_types
      {
        "web" => "sh nboot.sh"
        # "web" => "exec nginx/sbin/nginx"
      }
    end

    def webapp_path
      File.join(build_path,"webapps","ROOT")
    end
  end
end
