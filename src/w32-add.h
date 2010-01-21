## w32-add.h - Snippet to be be included into gpg-error.h.
## (Comments are indicated by a double hash mark)

/* A lean gettext implementation based on GNU style mo files which are
   required to be encoded in UTF-8.  There is a limit on 65534 entries
   to save some RAM.  Only Germanic plural rules are supported.  */
const char *_gpg_w32_bindtextdomain (const char *domainname,
                                     const char *dirname);
const char *_gpg_w32_textdomain (const char *domainname);
const char *_gpg_w32_gettext (const char *msgid);
const char *_gpg_w32_dgettext (const char *domainname, const char *msgid);
const char *_gpg_w32_dngettext (const char *domainname, const char *msgid1,
                                const char *msgid2, unsigned long int n);
const char *_gpg_w32_gettext_localename (void);
int _gpg_w32_gettext_use_utf8 (int value);

#define bindtextdomain(a,b) _gpg_w32_bindtextdomain ((a), (b))
#define textdomain(a)       _gpg_w32_textdomain ((a))
#define gettext(a)          _gpg_w32_gettext ((a))
#define dgettext(a,b)       _gpg_w32_dgettext ((a), (b))
#define ngettext(a,b,c)     _gpg_w32_dngettext (NULL, (a), (b), (c))
#define dngettext(a,b,c,d)  _gpg_w32_dngettext ((a), (b), (c), (d))
#define gettext_localname() _gpg_w32_gettext_localename ()
#define gettext_use_utf8(a) _gpg_w32_gettext_use_utf8 (a)