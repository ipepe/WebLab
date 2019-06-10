# WebLab - Work in Progress
WebLab is Your companion that focuses on serving static websites from zip archive files on the fly.

It uses two Sinatra servers, one for administration, and second for serving files. On admin You upload zip file and specify domain. When upload finishes, administrative service will restart public facing service with new configuration that includes Your new file.

# todo:
 * admin panel (api endpoint)
 * option for website: SPA=True (Single Page Application)
 * database-less config like traefik?
 * two separate applications on same image
   * one for serving zip files (weblab-public)
   * one for receiving zip files (and monitor?) (weblab-api)
   
# stage 1 - done
~~create weblab-public that responds with domain name in html to test with traefix and letsencrypt~~

# stage 2 - done
~~create weblab-api that accepts zip files and puts it for weblab-public and restarts weblab-public~~
