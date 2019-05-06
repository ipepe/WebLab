# weblab
WebLab is GitLab companion that focuses on serving static websites from zip archive files on the fly.

# todo:
 * pack with nginx and letsencrypt
   * notify letsencrypt about new domain
   * cron job for letsencrypt?
 * admin panel
 * option for website: SPA=True (Single Page Application)
 * database-less config like traefik?
 * two separate applications on same image
   * one for serving zip files
   * one for receiving zip files (and monitor?)
   
# stage 1
create app that responds with domain name in html to test with traefix and letsencrypt

