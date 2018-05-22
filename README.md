# sensu_server_chef

Cookbook to install and configure the base base Sensu Server for basic monitoring

## Supported Platforms

* Ubuntu 14.04 LTS
* Ubuntu 12.04 LTS
* CentOS 6.5
* CentOS 7

## Attributes
# sensu_server_chef cookbook attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['sensu']['use_ssl']</tt></td>
    <td>String</td>
    <td>Turns SSL on/off for the Sensu Server</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['sensu']['version']</tt></td>
    <td>String</td>
    <td>Used to lock the install base to a running version</td>
    <td><tt>1.2.1-2</tt></td>
  </tr>
  <tr>
    <td><tt>['sensu_server_chef']['mail_from']</tt></td>
    <td>String</td>
    <td>Alerts mail from </td>
    <td><tt>xxx@yourdomain.com</tt></td>
  </tr>
  <tr>
    <td><tt>['sensu_server_chef']['smtp_address']</tt></td>
    <td>String</td>
    <td>Alerts sent to </td>
    <td><tt>xxx@yourdomain.com</tt></td>
  </tr>
  <tr>
    <td><tt>['sensu_server_chef']['smtp_port']</tt></td>
    <td>String</td>
    <td> Port for SMTP </td>
    <td><tt>25</tt></td>
  </tr>
  <tr>
    <td><tt>['sensu_server_chef']['smtp_domain']</tt></td>
    <td>String</td>
    <td> SMTP domain </td>
    <td><tt>yourdomain.com</tt></td>
  </tr>
</table>

## Usage

Include sensu_server_chef::default and adjust attributes as necessary.  

### sensu_server_chef::default

Include `sensu_server_chef` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[sensu_server_chef::default]"
  ]
}
```


## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

Author:: Scalr.com
