package com.pts.exceptions;

public class OrganizationException extends RuntimeException {
    public OrganizationException() {
        super();
    }

    public OrganizationException(String message) {
        super(message);
    }

    public OrganizationException(String message, Throwable cause) {
        super(message, cause);
    }

    public OrganizationException(Throwable cause) {
        super(cause);
    }

    protected OrganizationException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
