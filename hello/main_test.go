package main

import (
	"testing"

	"github.com/Kong/go-pdk/test"
	"github.com/stretchr/testify/assert"
)

func TestPluginWithoutConfig(t *testing.T) {
	env, err := test.New(t, test.Request{
		Method:  "GET",
		Url:     "http://example.com?q=search&x=9",
		Headers: map[string][]string{"host": {"localhost"}},
	})
	assert.NoError(t, err)

	env.DoHttps(&Config{})
	assert.Equal(t, 200, env.ClientRes.Status)
	assert.Equal(t, "Go says hello to localhost", env.ClientRes.Headers.Get("x-hello-from-go"))
}

func TestPluginWithConfig(t *testing.T) {
	env, err := test.New(t, test.Request{
		Method:  "GET",
		Url:     "http://example.com?q=search&x=9",
		Headers: map[string][]string{"host": {"localhost"}},
	})
	assert.NoError(t, err)

	env.DoHttps(&Config{Message: "nice to meet you"})
	assert.Equal(t, 200, env.ClientRes.Status)
	assert.Equal(t, "Go says nice to meet you to localhost", env.ClientRes.Headers.Get("x-hello-from-go"))
}
