package phpipam

import (
	"fmt"
	"net/url"

	"github.com/pavel-z1/phpipam-sdk-go/controllers/addresses"
	"github.com/pavel-z1/phpipam-sdk-go/controllers/sections"
	"github.com/pavel-z1/phpipam-sdk-go/controllers/subnets"
)

// filterQuery builds the filter_by, filter_value and filter_match query
// string. filterMatch is one of "full", "partial" or "regex".
func filterQuery(filterBy, filterValue, filterMatch string) string {
	params := url.Values{}
	params.Set("filter_by", filterBy)
	params.Set("filter_value", filterValue)
	params.Set("filter_match", filterMatch)
	return params.Encode()
}

// getSubnetsInSectionFiltered GETs the subnets in a section, filtered on the
// server side.
func getSubnetsInSectionFiltered(c *sections.Controller, id int, filterBy, filterValue, filterMatch string) (out []subnets.Subnet, err error) {
	err = c.SendRequest("GET", fmt.Sprintf("/sections/%d/subnets/?%s", id, filterQuery(filterBy, filterValue, filterMatch)), &struct{}{}, &out)
	return
}

// getAddressesInSubnetFiltered GETs the addresses in a subnet, filtered on the
// server side.
func getAddressesInSubnetFiltered(c *subnets.Controller, id int, filterBy, filterValue, filterMatch string) (out []addresses.Address, err error) {
	err = c.SendRequest("GET", fmt.Sprintf("/subnets/%d/addresses/?%s", id, filterQuery(filterBy, filterValue, filterMatch)), &struct{}{}, &out)
	return
}
