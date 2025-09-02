package com.gsk.config;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.sql.Driver;
import java.sql.DriverManager;
import java.util.Enumeration;

import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;

@WebListener
public class AppContextListener implements ServletContextListener {

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		// No initialization required here for now
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		// Ensure MySQL Connector/J background threads are stopped on redeploy/shutdown
		try {
			AbandonedConnectionCleanupThread.checkedShutdown();
		} catch (InterruptedException ie) {
			Thread.currentThread().interrupt();
		} catch (Throwable t) {
			// ignore
		}

		// Deregister JDBC drivers that were registered by this webapp's ClassLoader
		try {
			ClassLoader webAppClassLoader = Thread.currentThread().getContextClassLoader();
			Enumeration<Driver> drivers = DriverManager.getDrivers();
			while (drivers.hasMoreElements()) {
				Driver driver = drivers.nextElement();
				if (driver.getClass().getClassLoader() == webAppClassLoader) {
					try {
						DriverManager.deregisterDriver(driver);
					} catch (Throwable t) {
						// ignore
					}
				}
			}
		} catch (Throwable t) {
			// ignore
		}
	}
}


