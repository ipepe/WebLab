# weblab
WebLab is Your companion that focuses on serving static websites from zip archive files on the fly.

# todo:
 * admin panel (api endpoint)
 * option for website: SPA=True (Single Page Application)
 * database-less config like traefik?
 * two separate applications on same image
   * one for serving zip files (weblab-public)
   * one for receiving zip files (and monitor?) (weblab-api)
   
# stage 1 - done
create weblab-public that responds with domain name in html to test with traefix and letsencrypt

# stage 2 - wip
create weblab-api that accepts zip files, checks if there is proper CNAME file inside zip, and puts it for weblab-public and restarts weblab-public

